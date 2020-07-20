require 'yaml'

YML_VAR = YAML.safe_load(File.read('config/variables.yml')) || {}
