require 'pry'

class TicTacToe
  attr_accessor :board

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize
    @board = Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts '-----------'
  end

  def input_to_index(string)
    target = string.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.reject { |space| space == ' ' }.count
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def turn
    puts 'Choose a number between 1 and 9:'
    input = gets
    index = input_to_index(input)
    if valid_move?(index)
      @board[index] = current_player
    else
      puts 'Invalid Move, try another space:'
      turn
    end
    display_board
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def won?
    x_arr = []
    o_arr = []
    @board.each_with_index do |input, index|
      x_arr << index if input == 'X'
      o_arr << index if input == 'O'
    end
    winning_combo = WIN_COMBINATIONS.select do |combo|
      combo.all? { |num| x_arr.include?(num) } | combo.all? { |num| o_arr.include?(num) }
    end
    winning_combo != [] ? winning_combo.flatten : false
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def full?
    @board.none? { |input| input == ' ' }
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? | won?
  end

  def winner
    if won?
      current_player == 'X' ? 'O' : 'X'
    end
  end

  def play
    turn until over?
    if won?
      victor = winner
      puts "Congratulations #{victor}!"
    else puts "Cat's Game!"
    end
  end
end
