class Mall
  include Game

  def mall
    prompt do
      say "Welcome to Apocalypse Mall. To begin your adventure, press 1. You can quit at any time by pressing 0."

      route 1 => :mall_start
    end
  end

  def mall_start
    self.player.hasPhone = false
    self.player.hasClub = false
    self.player.hasMakeup = false
    self.player.hasHat = false
    self.player.hasIceCream = false
    self.player.handsFull = false
    self.player.activeCultists = false
#     say "visited is #{self.game.visited}"
#     if self.game.visited.has_key?("bingbong")
#       say "yup"
#     else
#       say "nope"
#     end
#   	  say "You have lost. Your final score is #{self.player.score} #{"point".pluralize(self.player.score)}. Press 1 to play again."
  	  
    redirect :before_mall
  end
  
  def before_mall
    prompt do
      say "You have found the place the legends spoke of, a pool of glass in the jungle floor. You stand in its center. Press 1 to jump."
      
      route 1 => :mall_entrance
    end
  end
  
  def mall_entrance
  	prompt do
  	  if !self.player.visitedEntrance
  	    say "You crash through the glass down into the legendary Mall of the Ancients. You have been chosen to retrieve the Great Phone and travel back through the Wildlands, with a protective helmet to assure your safe return. You see crumbling, overgrown signs nearby. To go to the Wet Seal, press 1. To go to the Sephora, press 2."
  	    self.player.visitedEntrance = true
  	  else 
  	    say "You are back at the entrance. To go to the Wet Seal, press 1. To go to Sephora, press 2."
  	  end
  	  
  	  route 1 => :mall_wet_seal
  	  route 2 => :mall_sephora
  	end
  end
  
  def mall_sephora
  	prompt do
  	  if !self.game.visitedSephora
  	    say "You have found glittering pools of ancient cosmetics, fashioned by the elders out of exotic materials we no longer know. This is Sephora."
  	    self.game.visitedSephora = true
  	  else 
  	    say "You are in Sephora."
  	  end
  	  
  	  say "To venture into the REI, press 1. To return to the entrance, press 2."

  	  if self.game.activeCultists and !self.player.hasMakeup
  	    say "To disguise yourself as a cultist by wearing their war paint, press 3."
      end
  	  
      route 1 => :mall_attempt_rei_upper
      route 2 => :mall_entrance
      route 3 => :mall_sephora_makeup_activated
    end
  end
  
  def mall_sephora_makeup_activated
    say "Soon your face is fearsomely striped with colors from beyond time. The cultists will ignore you now."
    self.player.hasMakeup = true
    
    redirect :mall_sephora
  end
  
  def mall_attempt_rei_upper
    if self.game.visited.key?("rei_upper")
      redirect :mall_rei_upper
    else
      if self.player.hasClub and !self.game.visited("rei_upper")
        say "Your mighty club makes short work of the forbidding doors. You drop it and step through the sharp remains into the REI."
        self.player.hasClub = false
        self.player.handsFull = false
        redirect :mall_rei_upper
      else
        say "The heavy doors are made of reinforced glass. You can see through them, but cannot enter."
        redirect :mall_sephora
      end
    end
  end
  
  def mall_rei_upper
    prompt do
      if !self.game.visited.key?("rei_upper")
        say "You stand within the REI. A tent sags under the weight of vines, and ratlike vermin nest within a heap of moldering boots. A rack of double-billed hats, however, is undisturbed."
        self.game.visited["rei_upper"] = true
      else 
        say "You are in REI."
      end
      
      say "Press 1 to go to Sephora."
      
      if self.game.visited.key?("rei_lower")
        say "Press 2 to descend the stairs."
      end
      
      if !self.player.hasHat
        say "To wear the special neck-protecting hat, press 3."
      end
  	  
      route 1 => :mall_sephora
      route 2 => :mall_rei_lower
      route 3 => :mall_rei_upper_wear_hat
    end
  end
  
  def mall_rei_upper_wear_hat
  	say "The hat is now yours. It will protect you from the post-apocalyptic sun."
  	
  	if self.player.hasMakeup
  	  say "Combined with your face paint, you now bear all the markings of a fierce warrior."
  	end
  	
  	self.player.hasHat = true
  	
  	redirect :mall_rei_upper
  end
  
  def mall_rei_lower
    prompt do
      if !self.game.visited.key?("rei_lower")
        say "The lower cavern of the REI is a thicket of Gore-Tex and hiking poles, its energy bars long since consumed."
        if self.game.visited.key?("rei_upper")
          say "Wait, LOWER cavern? Hey, there were stairs to the second floor here all along! What the fuck!"
        end
        self.game.visited["rei_lower"] = true
      else
        say "You stand in the lower cavern of the REI."
      end
      
      say "Press 1 to climb the stairs. Press 2 to go to Yankee Candle."
      
      route 1 => :mall_rei_upper
      #route 2 => :mall_yankee_candle
    end
  end

#   def flappy_recurse
#     self.player.height = self.player.height.to_i
# 
#     if self.player.height > 0
#       self.player.height -= 1
#     end
# 
#     if self.player.height > 2
#       self.player.height = 2
#     end
# 
#     if self.player.flappy_first == "true"
#       self.player.flappy_first = false
#     else
#       if (self.player.height != self.player.pipe_height.to_i)
#        redirect :flappy_lost
#        return
#       end
# 
#       self.player.flappy_score = self.player.flappy_score.to_i + 1
#       say "#{self.player.flappy_score} #{"point".pluralize(self.player.flappy_score)}."
#     end
# 
#     self.player.pipe_height = Random.rand(3)
# 
#     prompt timeout: 1 do
#       say "You are flying at a #{flappy_height self.player.height} height. A pipe is approaching with a #{flappy_height self.player.pipe_height} height."
#       route 1 => :flap
#     end
# 
#     redirect :flappy_recurse
#   end
# 
#   def flap
#     self.player.height = self.player.height.to_i + 2
#     redirect :flappy_recurse
#   end
# 
#   def flappy_lost
#     prompt do
#       say "You have lost. Your final score is #{self.player.flappy_score} #{"points".pluralize(self.player.flappy_score.to_i)}. Press 1 to play again."
#       route 1 => :flappy_start
#     end
#   end
# 
#   private
# 
#   def flappy_height(height)
#     case height
#     when 0
#       "low"
#     when 1
#       "medium"
#     when 2
#       "high"
#     end
#   end
end
