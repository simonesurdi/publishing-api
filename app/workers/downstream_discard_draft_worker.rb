class DownstreamDiscardDraftWorker
  attr_reader :base_path, :content_id, :payload_version, :update_dependencies, :ignore_base_path_conflict

  include DownstreamQueue
  include Sidekiq::Worker
  include PerformAsyncInQueue

  sidekiq_options queue: HIGH_QUEUE

  def perform(args = {})
    assign_attributes(args.symbolize_keys)

    DownstreamMediator.delete_from_draft_content_store(base_path) if base_path

    enqueue_dependencies if update_dependencies
  rescue DiscardDraftBasePathConflictError => e
    Airbrake.notify_or_ignore(e) unless ignore_base_path_conflict
  rescue AbortWorkerError, DownstreamInvariantError => e
    Airbrake.notify_or_ignore(e)
  end

private

  def assign_attributes(attributes)
    @base_path = attributes.fetch(:base_path)
    @content_id = attributes.fetch(:content_id)
    @payload_version = attributes.fetch(:payload_version)
    @update_dependencies = attributes.fetch(:update_dependencies, true)
    @ignore_base_path_conflict = attributes.fetch(:ignore_base_path_conflict, false)
  end

  def enqueue_dependencies
    DependencyResolutionWorker.perform_async(
      content_store: draft_content_store,
      fields: [:content_id],
      content_id: content_id,
      payload_version: payload_version,
    )
  end
end
