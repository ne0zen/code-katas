require 'bowling'

# tests for bowling scorer
# (API by Chicago organization which will remain nameless)
describe Bowling::Frame do
  it "properly scores an open frame" do
    frame1 = Bowling::Frame.new
    frame1.roll(5)
    frame1.roll(1)
    frame1.game_score.should == 6

    frame2 = frame1.next_frame
    frame2.game_score.should == nil
  end

  describe "spare frame" do
    before :each do
      @frame1 = Bowling::Frame.new
      @frame1.roll(5)
      @frame1.roll(5)
      @frame2 = @frame1.next_frame
    end

    it "frame should be spare?" do
      @frame1.should be_spare
    end

    it "frame should not have a score" do
      @frame1.game_score.should == nil
    end

    describe "after roll in next_frame" do
      before :each do
        @frame2.roll(1)
      end

      it "properly scores spare frame" do
        @frame1.game_score.should == 11
      end

      it "next frame should be blank" do
        @frame2.game_score.should == nil
      end
    end
  end

  describe "strike frame" do
    before :each do
      @frame1 = Bowling::Frame.new
      @frame1.roll(10)

      @frame2 = @frame1.next_frame
    end

    it "should be a strike" do
      @frame1.should be_strike
    end
    
    it "should be blank" do
      @frame1.game_score.should == nil
    end
    
    describe "after 1 roll in next (open) frame" do
      before :each do
        @frame2.roll(1)
      end

      it "strike frame should be blank" do
        @frame1.game_score.should == nil
      end

      it "next frame should be blank" do
        @frame2.game_score.should == nil
      end
    end

    describe "after two rolls in next (open) frame" do
      before :each do
        @frame2.roll(1)
        @frame2.roll(2)
      end

      it "strike frame have a score" do
        @frame1.game_score.should == 13
      end

      it "next frame should have game total" do
        @frame2.game_score.should == 16
      end
    end
  end
end

