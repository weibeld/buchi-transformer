require 'automaton'
require 'base64'


class AutomataController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def random
    automaton = Automaton.generate_random
    @yaml_string = automaton.to_yaml
    @svg_data_uri = svg_data_uri(automaton.draw)
  end

  def draw
    @side = params[:side]
    automaton = Automaton.new(params[:yaml])
    @svg_data_uri = svg_data_uri(automaton.draw)
  end

  def transform
    automaton_1 = Automaton.new(params[:yaml])
    case params[:algo]
    when "subset_construction"
      automaton_2 = automaton_1.subset_construction
    when "copy"
      automaton_2 = automaton_1
    end
    @yaml_string = automaton_2.to_yaml
    @svg_data_uri = svg_data_uri(automaton_2.draw)
  end

private
  def parameters
    params.permit(:yaml, :side, :algo)
  end

  def svg_data_uri(string)
    "data:image/svg+xml;base64," + Base64.encode64(string)
  end
end
