# frozen_string_literal: true
# This sets up aliases for old Metasearch query methods so they behave
# identically to the versions given in Ransack.
#
Ransack.configure do |config|
  { "contains" => "cont", "starts_with" => "start", "ends_with" => "end" }.each do |old, current|
    config.add_predicate old, Ransack::Constants::DERIVED_PREDICATES.detect { |q, _| q == current }[1]
  end

  { "equals" => "eq", "greater_than" => "gt", "less_than" => "lt" }.each do |old, current|
    config.add_predicate old, arel_predicate: current
  end

  config.add_predicate 'gteq_date',
                        arel_predicate: 'gteq',
                        formatter: proc { |v| v.beginning_of_day },
                        type: :date

  config.add_predicate 'lteq_date',
                        arel_predicate: 'lteq',
                        formatter: proc { |v| v.end_of_day },
                        type: :date

  config.add_predicate "gteq_datetime",
                       arel_predicate: "gteq",
                       formatter: ->(v) { v.beginning_of_day },
                       type: :date

  config.add_predicate "lteq_datetime",
                       arel_predicate: "lteq",
                       formatter: ->(v) { v.end_of_day },
                       type: :date
end
