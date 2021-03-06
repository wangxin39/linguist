require_relative "./helper"

class TestPedantic < Test::Unit::TestCase
  filename = File.expand_path("../../lib/linguist/languages.yml", __FILE__)
  LANGUAGES = YAML.load(File.read(filename))
  GRAMMARS = YAML.load(File.read(File.expand_path("../../grammars.yml", __FILE__)))

  def test_language_names_are_sorted
    assert_sorted LANGUAGES.keys
  end

  def test_extensions_are_sorted
    LANGUAGES.each do |name, language|
      extensions = language['extensions']
      assert_sorted extensions[1..-1] if extensions && extensions.size > 1
    end
  end

  def test_filenames_are_sorted
    LANGUAGES.each do |name, language|
      assert_sorted language['filenames'] if language['filenames']
    end
  end

  def test_grammars_are_sorted
    assert_sorted GRAMMARS.keys
  end

  def test_scopes_are_sorted
    GRAMMARS.values.each do |scopes|
      assert_sorted scopes
    end
  end

  def assert_sorted(list)
    list.each_cons(2) do |previous, item|
      flunk "#{previous} should come after #{item}" if previous > item
    end
  end
end
