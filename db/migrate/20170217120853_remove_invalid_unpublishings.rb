class RemoveInvalidUnpublishings < ActiveRecord::Migration[5.0]
  def up
    ids = [
      730722,
      783246,
      791030,
      584528,
      715583,
      584523,
      762308,
      572178,
      788391,
      783245,
      796821,
      782804,
      729531,
      584530,
      783247,
      729214,
      788514,
      584515,
      588405,
      572340,
      584524,
      588399,
      787997,
      782798,
      588412,
      584520,
      715948,
      792860,
      792083,
      584513,
      790789,
      787986,
      589260,
      572347,
      751227,
      588591,
      627374,
      782799,
      584527,
      588413,
      588592,
      588404,
      730738,
      794649,
      783249,
      588408,
      588409,
      787985,
      791017,
      572057,
      588771,
      783250,
      782801,
      782797,
      572343,
      651881,
      572348,
      584519,
      629731,
      791036,
      792976,
      787996,
      800099,
      801468,
      730905,
      783248,
      782590,
      572345,
      721919,
      787988,
      588414,
      716580,
      787995,
      588400,
      729930,
      791042,
      791032,
      572346,
      638902,
      793200,
      572341,
      572349,
      788515,
      789807,
      638874,
      638958,
      788520,
      572344,
      719125,
    ]

    Unpublishing.delete_all(edition_id: ids)
  end
end
