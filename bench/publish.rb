# /usr/bin/env ruby

require ::File.expand_path('../../config/environment', __FILE__)
require 'benchmark'
require 'securerandom'

require 'faker'
require 'stackprof'

abort "Refusing to run outside of development" unless Rails.env.development?

def publish(editions)
  puts Benchmark.measure {
    editions.each do |item|
      Commands::V2::Publish.call(content_id: item[:content_id], update_type: 'major')
      print "."
    end
    puts ""
  }
end

$queries = 0
ActiveSupport::Notifications.subscribe "sql.active_record" do |name, started, finished, unique_id, data|
  $queries += 1
end

editions = 100.times.map do
  title = Faker::Company.catch_phrase
  {
    content_id: SecureRandom.uuid,
    schema_name: "placeholder",
    document_type: "placeholder",
    title: title,
    base_path: "/performance-testing/#{title.parameterize}",
    description: Faker::Lorem.paragraph,
    public_updated_at: Time.now.iso8601,
    locale: "en",
    routes: [
      {path: "/performance-testing/#{title.parameterize}", type: "exact"}
    ],
    redirects: [],
    publishing_app: "performance-testing",
    rendering_app: "performance-testing",
    details: {},
    phase: 'live',
    need_ids: []
  }
end

begin
  puts "Creating drafts..."
  editions.each do |item|
    Commands::V2::PutContent.call(item)
  end

  $queries = 0

  puts "Publishing..."

  StackProf.run(mode: :wall, out: "tmp/publish_wall.dump") { publish(editions) }

  puts "#{$queries} SQL queries"

  puts "Creating new drafts..."
  editions.each do |item|
    Commands::V2::PutContent.call(item.merge(title: Faker::Company.catch_phrase))
  end

  $queries = 0

  puts "Superseding..."

  StackProf.run(mode: :wall, out: "tmp/supersede_wall.dump") { publish(editions) }

  puts "#{$queries} SQL queries"

ensure
  scope = Edition.where(publishing_app: 'performance-testing')
  LinkSet.includes(:links).where(content_id: scope.pluck(:content_id)).destroy_all
  PathReservation.where(publishing_app: 'performance-testing').delete_all
  scope.delete_all
end
