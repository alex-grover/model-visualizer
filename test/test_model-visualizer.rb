require 'minitest/autorun'
require 'model-visualizer'

class ModelVisualizerTest < MiniTest::Unit::TestCase
  def test_run_returns_nil
    assert_equal ModelVisualizer.run, nil
  end
end
