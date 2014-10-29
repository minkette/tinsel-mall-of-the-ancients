class Mall
  include Game

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
  	  
  	  route 1 => :wet_seal
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
  
  def wet_seal
  	prompt do
  	  if !self.game.visitedWetSeal
  	    say "There is no actual Seal here."
  	    self.game.visitedWetSeal = true
  	  else 
  	    say "You are in Wet Seal."
  	  end
  	  
  	  say "To venture into the mysterious rooms of rest, press 1. To return to the entrance, press 2."
  	  
      route 1 => :restroooms
      route 2 => :mall_entrance
    end
  end
  
  def mall_sephora_makeup_activated
    say "Soon your face is fearsomely striped with colors from beyond time. The cultists will ignore you now."
    self.player.hasMakeup = true
    
    redirect :mall_sephora
  end
  
  def mall_attempt_rei_upper
    if self.game.visitedREIUpper
      redirect :mall_rei_upper
    else
      if self.player.hasClub and !self.game.visitedREIUpper
        say "Your mighty club makes short work of the forbidding doors. You drop it and step through the sharp remains into the REI."
        self.player.hasClub = false
        self.player.handsFull = false
        self.player.visitedREIUpper = true
        redirect :mall_rei_upper
      else
        say "The heavy doors are made of reinforced glass. You can see through them, but cannot enter."
        redirect :mall_sephora
      end
    end
  end
  
  def mall_rei_upper
    prompt do
      if !self.game.visitedREIUpper
        say "You stand within the REI. A tent sags under the weight of vines, and ratlike vermin nest within a heap of moldering boots. A rack of double-billed hats, however, is undisturbed."
        self.game.visitedREIUpper = true
      else 
        say "You are in REI."
      end
      
      say "Press 1 to go to Sephora."
      
      if self.game.visitedREILower
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
      if !self.game.visitedREILower
        say "The lower cavern of the REI is a thicket of Gore-Tex and hiking poles, its energy bars long since consumed."
        if self.game.visitedREIUpper
          say "Wait, LOWER cavern? Hey, there were stairs to the second floor here all along! What the fuck!"
        end
        self.game.visitedREILower = true
      else
        say "You stand in the lower cavern of the REI."
      end
      
      say "Press 1 to climb the stairs. Press 2 to go to Yankee Candle."
      
      route 1 => :mall_rei_upper
      route 2 => :yankee_candle
    end
  end

  def restrooms
    prompt do
      if !self.game.visitedRestrooms
        say "the smell is unbearable. A sign invites you to rest in this room. Why would you do that? Press 1 to head west. Press 2 to go east. Press 3 to go south. "
        self.game.visitedRestrooms = true
        route 1 => :holister
        route 2 => :escalator
        route 3 => :wet_seal
        pause
        pause 
        pause
        say "you feel nauseous and faint."
        pause 
        #end ? To end the 'prompt do' before the redirect??
        redirect :dead
      else
        say "the vile restrooms. Press 1 to head west. Press 2 to go east. Press 3 to go south. "
        route 1 => :holister
        route 2 => :escalator
        route 3 => :wet_seal
        pause
        pause 
        pause
        say "you feel nauseous and faint."
        pause 
        redirect :dead
      end
    end
  end

  def dead
    say "you died a miserable death in a shopping Mall. Just like your guidance councillor predicted. How sad. Please hold the line to start over"
    redirect :mall
  end
#probably needs something else here to make it hang up?

  def escalator
  	if !self.player.visitedEscalator 
  		prompt do
  			say "you see a staircase powered by an ancient mysterious technology. It churns unceasingly downwards. A thin chord crossed the top with a sign that reads, cleaning in progress, no entry. It is impassable. Press 1 to go west. Press 2 to go east."
  		  self.game.visitedEscalator = true
  
  			route 1 => :restrooms
  			route 2 => :movie_theater
      end
  	else
  		prompt do
  			say "you are at the useless escalator. Press 1 to go west. Press two to go east." 
  			
  			route 1 => :restrooms
  			route 2 => :movie_theater
  		end
  	end
  end

  def movie_theater
  	if !self.player.visitedMovieTheater 
  		prompt do
  			say "press 1 to go west. Press 2 to go south. Press 3 for movie listings in your local area"
  		self.game.visitedMovieTheater = true
  
  			route 1 => :escalator
  			route 2 => :railing
  			route 3 => :read_posters
      end
  	else
  		prompt do
  			say "press 1 to go west. Press 2 to go south. Press 3 for movie listings in your local area" 
  			
  			route 1 => :escalator
  			route 2 => :railing
  			route 3 => :read_posters
  		end
  	end
  end

  def read_posters
  	if !self.player.visitedReadPosters
  		prompt do
  			say "xxx"
        self.game.visitedReadPosters = true
  
  			route 1 => :movie_theater
      end
  	else
  		prompt do
  			say "xxxx" 
  			
  			route 1 => :movie_theater
  		end
  	end
  end

  def builda_bear
  	if !self.player.visitedBuildABear
  		prompt do
  			say "This is the Build-A-Bear. Press 1 to go to Hollister. Press 2 to go to Wet Seal."
  		  self.game.visitedBuildABear = true
  
  			route 1 => :holister
  			route 2 => :wet_seal
      end
  	else
  		prompt do
  			say "This is the Build-A-Bear. Press 1 to go to Hollister. Press 2 for Wet Seal." 
  			
  			route 1 => :holister
  			route 2 => :wet_seal
  		end
  	end
  end

  def railing
  	if !self.player.visitedRailing
  		prompt do
  			say "You are leaning on the railing. Press 1 to go to the movie theater. Press 2 to enter Golfsmith."
        self.game.visitedRailing = true
  
  			route 1 => :movie_theater
  			route 2 => :golfsmith
      end
  	else
  		prompt do
  			say "You are leaning on the railing. Press 1 to go to the movie theater. Press 2 to enter Golfsmith."
  			
  			route 1 => :movie_theater
  			route 2 => :golfsmith
  		end
  	end
  end
  
  def golfsmith
  	if !self.player.visitedGolfsmith
  		prompt do
  			say "You have discovered the mighty smith of ancient golfs. Press 1 to leave."
        self.game.visitedGolfsmith = true
  
  			route 1 => :railing
      end
  	else
  		prompt do
  			say "You are in Golfsmith. Press 1 to leave." 
  			
  			route 1 => :railing
  		end
  	end
  end

  #lower floor rooms
  
  def apple_store
  	if !self.player.visitedAppleStore
  		prompt do
  			say "You have found an Apple Store, but all the fruit is gone from this sterile place. Press 1 to return to the food court."
        self.game.visitedAppleStore = true
  
  			route 1 => :food_court_west
      end
  	else
  		prompt do
  			say "You are in the Apple Store. Press 1 to return to the food court." 
  			
  			route 1 => :food_court_west
  		end
  	end
  end
  
  def fountain
  	if !self.player.visitedFoodCourtWest
  		prompt do
  			say "The western side of the food court is devoid of joy. Press 1 to enter the Apple Store. Press 2 to gaze upon the fountain."
        self.game.visitedFoodCourtWest = true
  
  			route 1 => :fountain
  			route 2 => :apple_store
      end
  	else
  		prompt do
  			say "West Food Court. Press 1 to enter the Apple Store. Press 2 to gaze upon the fountain."
  			
  			route 1 => :fountain
  			route 2 => :apple_store
  		end
  	end
  end
  
  def fountain
  	if !self.player.visitedFountain
  		prompt do
  			say "You stand in the dry mosaic fountain bowl, ancient copper discs scattered around your feet. Press 1 to go to the western half of the food court, and 2 to go east. Press 3 to enter Yankee Candle."
        self.game.visitedFountain = true
  
  			route 1 => :food_court_west
  			route 2 => :food_court_east
  			route 3 => :yankee_candle
      end
  	else
  		prompt do
  			say "You are in the fountain. Press 1 to go to the western half of the food court, and 2 to go east. Press 3 to enter Yankee Candle." 
  			
  			route 1 => :food_court_west
  			route 2 => :food_court_east
  			route 3 => :yankee_candle
      end
  	end
  end
  
  def food_court_east
  	if !self.player.visitedFoodCourtEast
  		prompt do
  			say "The eastern side of the food court is a forgotten promise of feasts. Press 1 to gaze upon the fountain. Press 2 to partake in Spencer's Gifts."
        self.game.visitedFoodCourtEast = true
  
  			route 1 => :fountain
  			route 2 => :spencers_gifts
      end
  	else
  		prompt do
  			say "The eastern food court. Press 1 to gaze upon the fountain. Press 2 to partake in Spencer's Gifts." 
  			
  			route 1 => :fountain
  			route 2 => :spencers_gifts
  		end
  	end
  end
  
  def yankee_candle
  	if !self.player.visitedYankeeCandle
  		prompt do
  			say "You are in Yankee Candle. Press 1 to look upon the fountain. Press 2 to enter the lower level of REI."
    		self.game.visitedYankeeCandle = true
  
  			route 1 => :fountain
  			route 2 => :mall_rei_lower
      end
  	else
  		prompt do
  			say "You are in Yankee Candle. Press 1 to look upon the fountain. Press 2 to enter the lower level of REI." 
  			
  			route 1 => :fountain
  			route 2 => :mall_rei_lower
  		end
  	end
  end
  
  def spencers_gifts
  	if !self.player.visitedSpencersGifts
  		prompt do
  			say "Spencer has many gifts, but you don't think you want to open them. Press 1 to return to the food court. Press 2 to go down the access tunnel."
        self.game.visitedSpencersGifts = true
  
  			route 1 => :food_court_east
  			route 2 => :access_tunnel
      end
  	else
  		prompt do
  			say "You are in Spencer's Gifts. Press 1 to return to the food court. Press 2 to go down the access tunnel." 
  			
  			route 1 => :food_court_east
  			route 2 => :access_tunnel
  		end
  	end
  end
  
  def access_tunnel
  	if !self.player.visitedAccessTunnel
  		prompt do
  			say "The access tunnel is your way out of the Mall of the Ancients. Are you sure you're ready? Press 1 to enter the wasteland. Press 2 to return to Spencer's Gifts."
        self.game.visitedAccessTunnel = true
  
  			route 1 => :wasteland
  			route 2 => :spencers_gifts
      end
  	else
  		prompt do
  			say "The access tunnel. Press 1 to enter the wasteland. Press 2 to return to Spencer's Gifts." 
  			
  			route 1 => :wasteland
  			route 2 => :spencers_gifts
  		end
  	end
  end
  
  def wasteland
    say "You either win or lose!"
  end
  
end