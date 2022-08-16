# frozen_string_literal: true

# Active Record's fix for CVE-2022-32224 changed YAML deserialisation to use `safe_load`,
#  which by default is very restricted in which classes you can deserialise.
#
# See https://rubysec.com/advisories/CVE-2022-32224/
Rails.application.config.active_record.yaml_column_permitted_classes = [
  ActiveSupport::HashWithIndifferentAccess,
  Symbol
]
