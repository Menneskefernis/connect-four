require './lib/board'

describe Board do  
  describe "#create_board" do
    game_board = Board.new
    game_board.create_board

    it "sets up the board with nested 7 arrays" do
      expect(game_board.state.size).to eql(7)
    end

    it "sets the nested arrays with size 6" do
      expect(game_board.state[0].size).to eql(6)
    end
  end

  describe "#insert_disc" do
    game_board = Board.new
    game_board.create_board

    it "adds a disc to a column on the board" do
      disc = Disc.new("X")
      game_board.insert_disc(disc, 4)
      expect(game_board.state[4][0]).to eql(disc)
    end

    it "adds a disc on top of another" do
      disc2 = Disc.new("O")
      game_board.insert_disc(disc2, 4)
      expect(game_board.state[4][1]).to eql(disc2)
    end

    it "returns the position of the disk as coordinates" do
      disc3 = Disc.new("O")
      expect(game_board.insert_disc(disc3, 4)).to eql([4, 2])
    end
  end

  describe "#column_full?" do
    game_board = Board.new
    game_board.create_board

    it "returns false if a column is not full" do
      expect(game_board.column_full?(4)).to eql(false)
    end
  
    it "returns true if a column is full" do
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      disc5 = Disc.new("O")
      disc6 = Disc.new("O")

      game_board.insert_disc(disc1, 4)
      game_board.insert_disc(disc2, 4)
      game_board.insert_disc(disc3, 4)
      game_board.insert_disc(disc4, 4)
      game_board.insert_disc(disc5, 4)
      game_board.insert_disc(disc6, 4)
      expect(game_board.column_full?(4)).to eql(true)
    end
  end

  describe "#horizontal_match?" do
    it "returns true if there are four horizontal disks of same color in bottom left" do
      game_board = Board.new
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")

      game_board.insert_disc(disc1, 0)
      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc3, 2)
      game_board.insert_disc(disc4, 3)
      expect(game_board.horizontal_match?(disc1)).to eql(true)
    end
    
    it "returns true if there are four horizontal disks of same color in bottom right" do
      game_board = Board.new
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
  
      game_board.insert_disc(disc1, 3)
      game_board.insert_disc(disc2, 4)
      game_board.insert_disc(disc3, 5)
      game_board.insert_disc(disc4, 6)
      expect(game_board.horizontal_match?(disc1)).to eql(true)
    end
    
    it "returns false if another color comes in between a streak" do
      game_board = Board.new

      disc1 = Disc.new("O")
      disc2 = Disc.new("X") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      disc5 = Disc.new("O")
      disc6 = Disc.new("X")
  
      game_board.insert_disc(disc1, 1)
      game_board.insert_disc(disc2, 2)
      game_board.insert_disc(disc3, 3)
      game_board.insert_disc(disc4, 4)
      game_board.insert_disc(disc5, 5)
      game_board.insert_disc(disc6, 6)

      expect(game_board.horizontal_match?(disc3)).to eql(false)
    end

    it "returns false if there is a hole between disks" do
      game_board = Board.new
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc5 = Disc.new("O")
      disc6 = Disc.new("O")
      disc7 = Disc.new("O")

      game_board.insert_disc(disc1, 0)
      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc3, 2)
      game_board.insert_disc(disc5, 4)
      game_board.insert_disc(disc6, 5)
      game_board.insert_disc(disc7, 6)
      expect(game_board.horizontal_match?(disc2)).to eql(false)
    end

    it "returns true for four in a row even if not bottom row" do
        game_board = Board.new
        
        disc1 = Disc.new("O")
        disc2 = Disc.new("O") 
        disc3 = Disc.new("X")
        disc4 = Disc.new("X")
        disc5 = Disc.new("O")
        disc6 = Disc.new("O")
        disc7 = Disc.new("O")
  
        disc1_1 = Disc.new("X")
        disc2_1 = Disc.new("X") 
        disc3_1 = Disc.new("X")
        disc4_1 = Disc.new("X")

        game_board.insert_disc(disc1, 0)
        game_board.insert_disc(disc2, 1)
        game_board.insert_disc(disc3, 2)
        game_board.insert_disc(disc4, 3)
        game_board.insert_disc(disc5, 4)
        game_board.insert_disc(disc6, 5)
        game_board.insert_disc(disc7, 6)

        game_board.insert_disc(disc1_1, 3)
        game_board.insert_disc(disc2_1, 4)
        game_board.insert_disc(disc3_1, 5)
        game_board.insert_disc(disc4_1, 6)

        expect(game_board.horizontal_match?(disc2_1)).to eql(true)
      end
  end

  describe "#vertical_match?" do
    it "returns true if there is a vertical match" do
      game_board = Board.new
  
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
  
      game_board.insert_disc(disc1, 1)
      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc3, 1)
      game_board.insert_disc(disc4, 1)
  
      expect(game_board.vertical_match?(disc4)).to eql(true)
    end

    it "returns false if there are less than four discs" do
        game_board = Board.new
    
        disc1 = Disc.new("O")
        disc2 = Disc.new("O")
        disc3 = Disc.new("O")
    
        game_board.insert_disc(disc1, 1)
        game_board.insert_disc(disc2, 1)
        game_board.insert_disc(disc3, 1)
    
        expect(game_board.vertical_match?(disc3)).to eql(false)
      end

    it "returns false if there is a disc of another color in between a streak" do
        game_board = Board.new
    
        disc1 = Disc.new("O")
        disc2 = Disc.new("O")
        disc3 = Disc.new("X")
        disc4 = Disc.new("O")
        disc5 = Disc.new("O")
    
        game_board.insert_disc(disc1, 1)
        game_board.insert_disc(disc2, 1)
        game_board.insert_disc(disc3, 1)
        game_board.insert_disc(disc4, 1)
        game_board.insert_disc(disc5, 1)
    
        expect(game_board.vertical_match?(disc5)).to eql(false)
      end
  end

  describe "#diagonal_up_match?" do
    it "returns true if there is a diagonal match going up from left to right" do
      game_board = Board.new
  
      disc1_0 = Disc.new("O")
      disc2_0 = Disc.new("X") 
      disc1_1 = Disc.new("O")
      disc2_1 = Disc.new("X")
      disc3_0 = Disc.new("X")
      disc1_2 = Disc.new("O")
      disc4_0 = Disc.new("X")
      disc3_1 = Disc.new("X")
      disc2_2 = Disc.new("X")
      disc1_3 = Disc.new("O")
      
      game_board.insert_disc(disc1_0, 1)
      game_board.insert_disc(disc2_0, 2)
      game_board.insert_disc(disc1_1, 2)
      game_board.insert_disc(disc2_1, 3)
      game_board.insert_disc(disc3_0, 3)
      game_board.insert_disc(disc1_2, 3)
      game_board.insert_disc(disc4_0, 4)
      game_board.insert_disc(disc3_1, 4)
      game_board.insert_disc(disc2_2, 4)
      game_board.insert_disc(disc1_3, 4)
  
      expect(game_board.diagonal_up_match?(disc1_1)).to eql(true)
    end
  end

  #describe "#draw" do
  #it "draw an empty game board" do
  #  expect { game_board.draw }.to output(<<-MESSAGE.strip_heredoc).to_stdout
  #    | - | - | - | - | - | - | - |
  #    | - | - | - | - | - | - | - |
  #    | - | - | - | - | - | - | - |
  #    | - | - | - | - | - | - | - |
  #    | - | - | - | - | - | - | - |
  #    | - | - | - | - | - | - | - |
  #    -----------------------------
  #    | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
  #  OUTPUT
  #end
  #end
end