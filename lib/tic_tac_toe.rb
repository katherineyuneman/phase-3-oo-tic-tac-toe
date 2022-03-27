require 'pry'

class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS =  [
        [0,1,2],    #combo[0]
        [3,4,5],    #combo[1]
        [6,7,8],    #combo[2]
        [0,3,6],    #combo[3]
        [1,4,7],    #combo[4]
        [2,5,8],    #combo[5]
        [0,4,8],    #combo[6]
        [6,4,2]     #combo[7]
    ]
    
    @count = 0

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
        # @board = ["0","1","2","3","4","5","6","7","8"]
    end

    #helper methods

    def display_board
        @board.each.with_index do |cell, index|
            if index%3 == 0
                print " " + cell + " | "
            elsif index%3 == 1
                print cell + " | "
            elsif index%3 == 2
                print cell + " \n"
                puts "-----------" if index < @board.length - 1
            end
        end
    end

    def input_to_index(input)
        board_index = input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false: true
        # OR
        # @board[index] != " "
    end

    def valid_move?(position)
        !self.position_taken?(position) == true && position <= 8
    end

    def turn_count
        new_array = @board.sum do |cell|
            if cell != " "
                1
            else 0
            end
        end
    end

    def current_player
        turn_count%2 == 0  ? "X" : "O"
    end


    def turn
        puts "Make your move (1-9)"
        user_input = gets
        index = input_to_index(user_input)
        if (valid_move?(index))
            move(index, current_player)
            display_board
        else
            puts "Invalid Move.  Try Again."
            turn 
        end
    end


    def won?
        won = false
        result = nil
        WIN_COMBINATIONS.each do |combo|
            won = (@board[combo[0]] != " ") &&
            (@board[combo[0]] == @board[combo[1]]) &&
            (@board[combo[1]] == @board[combo[2]])
            if won
                result = combo
                break
            end
        end
        result
    end

    def full?
        full = false
        @board.each do |cell|
            full = cell == " " ? false : true
        end
        full
    end

    def draw?
        full? && !won? ? true : false
    end

    def over?
        !!won? || draw? ? true: false
    end

    def winner
        !!won? ? @board[won?[0]] : nil
    end

    def play
        turn
        if over? == true
            !!won? ? ("Congratulations, #{winner}") : (prints "Cat's Game!")
        else turn
        end
    end

end
