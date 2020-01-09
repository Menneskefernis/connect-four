require './lib/board'

describe Board do  
  describe "#create_board" do
    game_board = Board.new
    game_board.create_board(6, 7)

    it "sets up the board with nested 7 arrays" do
      expect(game_board.state.size).to eql(7)
    end

    it "sets the nested arrays with size 6" do
      expect(game_board.state[0].size).to eql(6)
    end
  end

  #describe "#create_board" do
  #  it "creates a multidimensional array of EmptySlots" do
  #    game_board = Board.new
  #    
  #    expect(EmptySlot).to receive(:new).with(0,0)
  #    expect(EmptySlot).to receive(:new).with(0,1)
  #    expect(EmptySlot).to receive(:new).with(1,0)
  #    expect(EmptySlot).to receive(:new).with(1,1)
  #    expect(game_board.create_board(2, 2)).to all( be_an(EmptySlot) )
  #  end
  #end

  describe "#insert_disc" do
    game_board = Board.new
    game_board.create_board(6, 7)

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
  end

  describe "#column_full?" do
    game_board = Board.new
    game_board.create_board(6, 7)

    it "returns false if a column is not full" do
      expect(game_board.column_full?(4)).to eql(false)
    end
  
    it "returns true if a column is full" do
      game_board.state[4].map! { |row| Disc.new("O") }
      expect(game_board.column_full?(4)).to eql(true)
    end
  end

  describe "#full?" do
    game_board = Board.new

    it "returns false if board is not full" do
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      disc5 = Disc.new("O")
      disc6 = Disc.new("O")

      game_board.insert_disc(disc1, 4)
      game_board.insert_disc(disc2, 2)
      game_board.insert_disc(disc3, 4)
      game_board.insert_disc(disc4, 6)
      game_board.insert_disc(disc5, 1)
      game_board.insert_disc(disc6, 4)

      expect(game_board.full?).to eql(false)
    end

    it "returns true if board is full" do
      game_board.state = game_board.state.map do |column|
        column.map do |row|
          row = Disc.new("X")
        end
      end

      expect(game_board.full?).to eql(true)
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
    it "returns true if there is a diagonal match going up from left to right in lower left corner" do
      game_board = Board.new
  
      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")

      game_board.insert_disc(disc1, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc3, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc4, 3)
  
      expect(game_board.diagonal_up_match?(disc3)).to eql(true)
    end

    it "returns true if there is a diagonal match going up from left to right in lower right corner" do
      game_board = Board.new
  
      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")

      game_board.insert_disc(disc1, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc2, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc3, 5)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc4, 6)
  
      expect(game_board.diagonal_up_match?(disc4)).to eql(true)
    end

    it "returns true if there is a diagonal match going up from left to right in upper left corner" do
      game_board = Board.new

      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc1, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc3, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc4, 3)
  
      expect(game_board.diagonal_up_match?(disc1)).to eql(true)
    end

    it "returns true if there is a diagonal match going up from left to right in upper right corner" do
      game_board = Board.new

      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 6)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc1, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc2, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc3, 5)
      game_board.insert_disc(disc_base, 6)

      game_board.insert_disc(disc4, 6)
  
      expect(game_board.diagonal_up_match?(disc2)).to eql(true)
    end

    it "returns false if there is another color breaking a diagonal match" do
      game_board = Board.new

      disc_base = Disc.new("X")

      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("X")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc1, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc3, 2)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc4, 3)
  
      expect(game_board.diagonal_up_match?(disc1)).to eql(false)
    end

    it "returns false if there is a hole in a diagonal streak" do
      game_board = Board.new

      disc_base = Disc.new("X")

      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc1, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)

      game_board.insert_disc(disc2, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)

      game_board.insert_disc(disc3, 3)
      game_board.insert_disc(disc_base, 4)

      game_board.insert_disc(disc4, 4)
  
      expect(game_board.diagonal_up_match?(disc1)).to eql(false)
    end
  end

  describe "#diagonal_down_match?" do
    it "returns true if there is a diagonal match going down from right to left in lower left corner" do
      game_board = Board.new
  
      disc_base = Disc.new("O")
      
      disc1 = Disc.new("X")
      disc2 = Disc.new("X")
      disc3 = Disc.new("X")
      disc4 = Disc.new("X")

      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc1, 3)

      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc2, 2)

      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc3, 1)

      game_board.insert_disc(disc4, 0)
  
      expect(game_board.diagonal_down_match?(disc3)).to eql(true)
    end

    it "returns true if there is a diagonal match going down from right to left in lower right corner" do
      game_board = Board.new
        disc_base = Disc.new("O")
      
      disc1 = Disc.new("X")
      disc2 = Disc.new("X")
      disc3 = Disc.new("X")
      disc4 = Disc.new("X")

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc1, 6)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc2, 5)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc3, 4)

      game_board.insert_disc(disc4, 3)

      expect(game_board.diagonal_down_match?(disc4)).to eql(true)
    end

    it "returns true if there is a diagonal match going down from right to left in upper left corner" do
      game_board = Board.new
      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 3)

      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc_base, 2)
      game_board.insert_disc(disc1, 3)

      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc_base, 1)
      game_board.insert_disc(disc2, 2)

      game_board.insert_disc(disc_base, 0)
      game_board.insert_disc(disc3, 1)

      game_board.insert_disc(disc4, 0)
  
      expect(game_board.diagonal_down_match?(disc1)).to eql(true)
    end

    it "returns true if there is a diagonal match going down from right to left in upper right corner" do
      game_board = Board.new
      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc_base, 6)
      game_board.insert_disc(disc_base, 6)
      
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc1, 6)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc2, 5)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc3, 4)

      game_board.insert_disc(disc4, 3)
      
      expect(game_board.diagonal_down_match?(disc2)).to eql(true)
    end

    it "returns false if there is another color breaking a diagonal match" do
      game_board = Board.new
      
      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("X")
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc1, 6)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc2, 5)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc3, 4)

      game_board.insert_disc(disc4, 3)
      
      expect(game_board.diagonal_down_match?(disc1)).to eql(false)
    end

    it "returns false if there is a hole in a diagonal streak" do
      game_board = Board.new
      
      disc_base = Disc.new("X")
      
      disc1 = Disc.new("O")
      disc2 = Disc.new("O") 
      disc3 = Disc.new("O")
      disc4 = Disc.new("O")
      
      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)
      game_board.insert_disc(disc_base, 5)
      game_board.insert_disc(disc1, 6)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc_base, 4)

      game_board.insert_disc(disc_base, 3)
      game_board.insert_disc(disc3, 4)

      game_board.insert_disc(disc4, 3)

      expect(game_board.diagonal_down_match?(disc1)).to eql(false)
    end
  end
end