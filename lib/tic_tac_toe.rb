require 'pry'

class TicTacToe 
  
   
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
    ]
  
  def initialize 
    i = 0
    new_board = []
    while i < 9 do
      new_board[i] = " " 
      i += 1 
    end 
    @board = new_board
  end  
  
  def display_board 
    i = 0
    puts "------------"
    while i < 9 do
    s = i + 1  
    if s % 3 != 0 
      print " #{@board[i]} |"
    else 
      puts " #{@board[i]} "
      puts "------------"
    end
    i += 1 
    end 
  end
  
  def input_to_index(input)
      index_input = input.to_i
      index_input = index_input - 1
  end
  
  def move(index, token = "X")
    @board[index] = token 
 #   binding.pry
  end
  
  def position_taken?(index) 
    !(@board[index] == " ") 
  end 
  
  def valid_move?(index)
    !(self.position_taken?(index)) && index < 9 && index > -1
  end
      
  def turn 
    input = gets
    input_move = self.input_to_index(input) 
    if !(self.valid_move?(input_move))
      until (self.valid_move?(input_move)) do
        input = gets
        input_move = self.input_to_index(input)
      end 
    end
    self.move(input_move,self.current_player)
    self.display_board
    input
  
  end
  
  def turn_count 
    i = 0
    turn = 0 
    while i < 9 
    if self.position_taken?(i) 
      turn += 1 
      i += 1
    else 
      i += 1
    end 
  end 
  turn
end
  
  def current_player 
    if (self.turn_count % 2 == 0) 
      "X" 
    else 
      "O"
    end 
  end
  
  def won? 
    matches = 0
    winning_combo = []
    WIN_COMBINATIONS.each do |set| 
      if @board[set[0]] != " "
        symbol = @board[set[0]]
      else symbol = "Empty" 
      end
      matches = 0 
      set.each do |index|
        if symbol == @board[index] 
          matches += 1 
        end 
        if matches == 3 
          winning_combo = set
        end
#binding.pry
        if winning_combo != []   
          return winning_combo
          binding.pry
          break
        end
      end
    end
    winning_combo != []
  end 
    
  def full?
    count = 0
    @board.each do |index| 
      if index == "X" || index == "O"
        count += 1
      end
    end
    count == 9 && !self.won?
  end
      
  def draw? 
    !self.won? && self.full?
  end
  
  def over?
    self.won? || self.draw? 
   
  end 
  
  def winner 
    #binding.pry
    if self.won?
       return @board[self.won?[0]]
     else 
       return nil
     end
  end
  
  
  def play 
    until (self.over?) 
      self.turn 
    end
      #binding.pry
    if self.won? 
      puts "Congratulations #{self.winner}!" 
    else
      puts "Cat's Game!" 
    end 
  end
 
end

current_game = TicTacToe.new
current_game.play

