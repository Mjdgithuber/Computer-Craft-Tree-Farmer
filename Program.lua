------------------------------------------------------
-- Spruce Tree Farmer  By OmegaBeard2000            --
-- 2016-8-22, v1.1.0   *shutdown location tool*     --
-- 2016-8-21, v1.0.3   bug fixes                    --
-- 2016-5-5, v1.0.2    fixed "going back" problem   --
-- 2016-5-4, v1.0.1    organized and added comments --
-- 2016-4-29, v1.0     *initial release*            --
------------------------------------------------------

------------------------------------------------------
------ Basic Methods ---------------------------------
------------------------------------------------------

function d() --Checks to see if anything is in front of the turtle, and if so it will break it
	if turtle.detect() then
		turtle.dig()
	end
end

function move(x) --Moves the turtle x amount
	for times = 0, x-1, 1 do
		turtle.forward()
	end
end

function moveD(x) --This will move the turtle forward and break the blocks in-front if a block is there
	for times = 0, x-1, 1 do
		d()
		turtle.forward()
	end
end

function digMove(x) --Digs then moves the turtle forward
	for amount = 0, x-1, 1 do
		turtle.dig()
		turtle.forward()
	end
end

function movePlaceDown(slot, x) --Choses slot moves then places down what is in that slot
	for start = 0, x-1, 1 do
		moveD(1)
		turtle.select(slot)
		if turtle.detectDown() then
			turtle.digDown()
		end
		turtle.placeDown()
	end
end

function clear() --Clears the console
	term.clear() term.setCursorPos(1,1)
end

function up(x) --Moves the turtle up x amount
	for amount = 0, x-1, 1 do
		turtle.up()
	end
end

function dUp() --Detect and break function
	if turtle.detectUp() then
		turtle.digUp()
	end
end

function upD(x) --Makes the turtle move up and break nessary blocks
	for amount = 0, x-1, 1 do
		dUp()
		turtle.up()
	end
end

function down(x) --Moves the turtle down x amount
	for amount = 0, x-1, 1 do
		turtle.down()
	end
end

function dDown() --Detect and break function
	if turtle.detectDown() then
		turtle.digDown()
	end
end

function downD(x) --Makes the turtle move down and break nessary blocks
	for amount = 0, x-1, 1 do
		dDown(1)
		turtle.down()
	end
end

function moveSD(x) --Move and then suck downwards
	for amount = 0, x-1, 1 do
		moveD(1)
		turtle.suckDown()
	end
end

function moveReplant(x) --Moves and then replants the sapling beneath it
	for amount = 0, x-1, 1 do
		moveD(1)
		turtle.placeDown()
	end
end

function turnAround() --This method turns the turtle around
	turtle.turnLeft()
	turtle.turnLeft()
end

function goBackToChest(location, reboot) --Finds the turtle location and sends it back to the chest
	if location == 0 then
		print("Already at chest")
	elseif location == 1 then
		upD(1)
		turnAround()
		moveD(5)
		downD(1)
		turnAround()
	elseif location == 2 then
		upD(1)
		turnAround()
		moveD(10)
		downD(1)
		turnAround()
	elseif location == 3 then
		upD(1)
		moveD(15)
		downD(1)
		turnAround()
	elseif location == 4 then
		upD(1)
		moveD(10)
		downD(1)
		turnAround()
	elseif location == 5 then
		upD(1)
		moveD(5)
		downD(1)
		turnAround()
	else --This should never happen
		print("The program has crashed. Rebooting...")
		sleep(5)
		os.reboot()
	end
	
	if reboot then --Makes the program reboot, first dropping its inventory in the chest
		dropInv()
		os.reboot()
	end
end

function goBackToLocation(location) --This goes back to the prevous location (It is now at the chest when this is called)
	if location == 0 then
		print("Already at previous location")	
	elseif location == 1 then
		upD(1)
		moveD(5)
		downD(1)
	elseif location == 2 then
		upD(1)
		moveD(10)
		downD(1)
	elseif location == 3 then
		upD(1)
		moveD(15)
		downD(1)
		turnAround()
	elseif location == 4 then
		upD(1)
		moveD(10)
		downD(1)
		turnAround()
	elseif location == 5 then
		upD(1)
		moveD(5)
		downD(1)
		turnAround()
	else
		print("The program has crashed. Rebooting...")
		sleep(5)
		os.reboot()
	end
end


------------------------------------------------------
------ Building Platform Methods ---------------------
------------------------------------------------------

function preSetup() --Tells the user what must be in the turtle to run the setup
	clear()
	print("+-------------------------------------+")
	print("|  Welcome To The Auto Setup Prompt   |")
	print("| To Run Please Place Items In Slots  |")
	print("| Slot 1: Saplings (24 min)           |")
	print("| Slot 2: Wood Log (1 Same as sapling)|")
	print("| Slot 12: Slabs (36 Any Type)        |")
	print("| Slot 13: Slabs (36 Any Type)        |")
	print("| Slot 14: Dirt (25)                  |")
	print("| Slot 15: Fuel (10 min, 64 preferred)|")
	print("| Slot 16: Chest (1)                  |")
	print("+-------------------------------------+")
	write("Press Enter When Ready Or Type Back: ")
	input = read()

	if input == "back" then
		rerun = true
	else
		setup()
		rerun = true
	end
end

function setup() --Calls everything necessary to build the farm
	refuel()
	checkFuel(0)
	turtle.digDown()
	turtle.select(16) --Last slot where the chest should be placed
	turtle.placeDown() --Places the chest below the turtle
	for amount = 0, 2, 1 do
		buildTreePlatform(13)
	end
	turnAround()
	for amount = 0, 2, 1 do
		buildTreePlatform(12)
	end
	turnAround()
	plantTrees()
end

function buildTreePlatform(y) --Builds one platform (y being the slot number of item)
	moveD(1)
	turtle.turnLeft()
	moveD(1)
	upD(1)
	movePlaceDown(y, 4)
	turtle.turnRight()
	movePlaceDown(y, 1)
	turtle.turnRight()
	movePlaceDown(14, 2)
	movePlaceDown(y, 1)
	turtle.turnLeft()
	movePlaceDown(y, 1)
	turtle.turnLeft()
	movePlaceDown(14, 2)
	movePlaceDown(y, 1)
	turtle.turnRight()
	movePlaceDown(y, 1)
	turtle.turnRight()
	movePlaceDown(y, 3)
	moveD(2)
	turtle.turnLeft()
	moveD(1)
	downD(1)
end

function plantOneSide() --Plants all trees on one side
	moveD(2)
	upD(2)
	turtle.turnLeft()
	moveD(2)
	movePlaceDown(1, 2)
	turtle.turnRight()
	moveD(1)
	turtle.turnRight()
	if turtle.detectDown() then
		turtle.digDown()
	end
	turtle.placeDown()
	movePlaceDown(1, 1)
	moveD(3)
	turtle.turnLeft()
	moveD(2)
	downD(2)
end

function plantTrees() --Calls everything necessary to plant all trees 
	for amount = 0, 2, 1 do
		plantOneSide()
	end

	turnAround()

	for amount = 0, 2, 1 do
		plantOneSide()
	end

	turnAround()

end


------------------------------------------------------
------ Managing Tree Farm Methods---------------------
------------------------------------------------------

function preTreeFarmer() --This tells you what you will need to get started
	clear()
	print("+-------------------------------------+")
	print("| Welcome To The Auto Felling Program |")
	print("| Before You Run Make Sure You Have...|")
	print("| 1. Generated The Farm               |")
	print("| 2. Have A Few Saplings In Slot 1    |")
	print("| 3. Have At Least 1 Log Of Matching  |")
	print("| Wood In Slot 2 (Same As Tree Type)  |")
	print("| 4. Have At Least 1 Dirt In Slot 14  |")
	print("| 5. Put Some Fuel In Slot 15         |")
	print("+-------------------------------------+")
	write("Press Enter When Ready Or Type Back: ")
	input = read()
	if input == "back" then
		rerun = true
	else
		treeFarmerLoop()
	end
end

function treeFarmerLoop() --This asks how many times you want the turtle to do one round
	clear()
	print("+-------------------------------------+")
	print("| The Program Runs in Loops. One Loop |")
	print("|    Will Check All Six Trees And     |")
	print("|   Cutting Them Down If Necessary.   |")
	print("| Please Enter Amount Of Loops Wanted |")
	print("|     Enter 0 For Infinite Loops.     |")
	print("+-------------------------------------+")
	write("Number Of Loops: ")
	input = read()

	infinite = false
	if input == "0" then
		infinite = true
	end
	
	while infinite do
		treeFarmer()
		dropInv()
	end

	for amount = 1, input, 1 do
		treeFarmer()
		dropInv()
	end

	print("Program Has Finished And Will Shutdown")
	sleep(7)
	os.shutdown()
end

function treeFarmer() --This calls everything necessary for one loop 
	for times = 0, 2, 1 do
		checkFuel(times)
		checkRedstone(times)
		checkInv(times, false)
		checkForTree()
	end
	
	turnAround()
	
	for times= 0, 2, 1 do
		checkFuel(times+3)
		checkRedstone(times+3)
		checkInv(times+3, false)
		checkForTree()
	end
	
	turnAround()
	
end

function mergeTreeSaps() --Takes all saplings and tries to move them to the sapling spot
	for slotNo = 2, 16, 1 do
		turtle.select(slotNo)
		turtle.transferTo(1)
	end
	turtle.select(1)
end

function replantSaps() --Replants the saplings on one platform
	mergeTreeSaps()	
	
	if turtle.getItemCount(1) >= 4 then
		upD(1)
		turnAround()
		moveD(2)
		turtle.turnLeft()
		moveD(1)
		moveReplant(2)
		turtle.turnRight()
		moveReplant(1)
		turtle.turnRight()
		moveReplant(1)
		moveD(2)
		turtle.turnRight()
		moveD(4)
		turtle.turnLeft()
		downD(2)
	else
		moveD(1)
		turtle.turnLeft()
		downD(1)
	end
end

function treeRevolve() --One complete circle around logs
	digMove(1)
	turtle.turnRight()
	digMove(1)
	turtle.turnRight()
	digMove(1)
end

function resetTreeRevolve() --Sends the turtle down one level to more tree logs
	turtle.turnRight()
	moveD(1)	
	turtle.turnRight()
	downD(1)
end

function checkForTree() --Checks to see if a grow tree is in a spot
	clear()
	print("Checking for tree...")
	upD(1)
	moveD(2)
	turtle.turnLeft()
	moveD(2)
	turtle.select(2)
	if turtle.compare() then
		cutTree()
	else
		turnAround()
		moveD(2)
		turtle.turnLeft()
		moveD(3)
		downD(1)
	end
end

function cutTree() --Cuts down the tree
	clear()
	print("Cutting Down Tree...")
	turtle.select(2)
	while turtle.compare() do
		upD(1)
	end
	upD(1)
	digMove(1)

	leafLvl = 0

	while turtle.compareDown() or leafLvl <= 2 do
		treeRevolve()

		if turtle.compareDown or leafLvl <= 2 then
			resetTreeRevolve()
		end

		leafLvl = leafLvl+1
	end
	turtle.select(14)--This would be dirt
	if turtle.compareDown() then
		treeRevolve()
		finishUpTree()
	else
		print("This is an error please re-run the program")
	end
	print("Done Cutting Tree")
end

function finishUpTree()
	--This part picks up the saplings on top of the cobble slab ring
	turtle.select(1)
	moveSD(1)
	turtle.turnRight()
	moveSD(2)
	turtle.turnRight()
	moveSD(3)
	turtle.turnRight()
	moveSD(3)
	turtle.turnRight()
	moveSD(3)

	--This part picks up the saplings on the ring one away from the cobble slab ring
	moveSD(1)
	turtle.turnRight()
	moveSD(4)
	turtle.turnRight()
	moveSD(5)
	turtle.turnRight()
	moveSD(5)
	turtle.turnRight()
	moveSD(5)
	
	replantSaps() --Replants the saplings
end


------------------------------------------------------
------ OS IO Methods ---------------------------------
------------------------------------------------------

function checkInv(location, goBack) --Checks to see if the inventory needs dumping, if so it will go back to the chest
	clear()
	if goBack == false then print("Checking to see if inventory needs to be dumped.") end
	if turtle.getItemCount(12) >= 1 then
		if goBack == false then print("Going to chest to dump inventory") end
		if goBack == false then goBackToChest(location, false) end
		
		dropInv()

		if turtle.getItemCount(12) >= 1 then 
			print("Not Enough Inventory Space")
			write("Press Enter When Chest Is Emptied: ")
			read()
			checkInv(location)
		else
			print("Done. Going back to previous location. ")
			goBackToLocation(location)
		end
	else
		print("Adequate inventory space remains")
		if goBack then
			print("Done. Going back to previous location. ")
			goBackToLocation(location)
		end
	end
end

function dropInv() --Drops inventory in the chest
	turtle.select(2)
	turtle.dropDown((math.max(turtle.getItemCount(2), 1)-1))
	for drop = 3, 13, 1 do
		turtle.select(drop)
		turtle.dropDown()
	end
	turtle.select(14)
	turtle.dropDown((math.max(turtle.getItemCount(14), 1)-1))
	turtle.select(16)
	turtle.dropDown()
end

function checkFuel(location) --Checks to make sure there is enough fuel and attempts to refuel if it needs to
	clear()
	turtle.select(15)
	print("Fuel Level: "..turtle.getFuelLevel())
	if turtle.getFuelLevel()<= 275 then
		print("Refueling is necessary. An attempt will be made")
		turtle.refuel(16)
		print("New Fuel Level: "..turtle.getFuelLevel()..", 275 is required")
		if turtle.getFuelLevel()<= 275 then
			print("The attempt failed.")
			print("The turtle will await fuel.")
			print("Please put fuel in slot #15.")
			write("Then press enter, or type stop: ")
			input = read()
			if input == "stop" or input == "Stop" then
				print("Going back to chest...")
				goBackToChest(location, true)
			else
				turtle.refuel(16)
				checkFuel(location)
			end
		else
			print("The attempt was successful!")
		end
	else
		print("Fuel level stable and is at "..turtle.getFuelLevel())
	end
end

function refuel() --Refuels the turtle
	turtle.select(15)
	turtle.refuel()
end


------------------------------------------------------
------ Redstone Methods ------------------------------
------------------------------------------------------

function redstoneHelp() --Intended to help the user understand how to use redstone to stop the turtle
	clear()
	print("+-------------------------------------+")
	print("| After Starting The Program You Might|")
	print("|   Wish To Stop The Turtle For Any   |")
	print("| Reason Like When Leaving The Server |")
	print("|  (Because The Program Will Stop In  |")
	print("|     A Random Spot When You Leave).  |")
	print("| To Stop The Turtle Place A Redstone |")
	print("|  Torch On The Left Or Right Of The  |")
	print("|       Middle Of An Intersection     |")
	print("+-------------------------------------+")
	write("Press Enter To Go To The Diagram: ")
	read()
	clear()
	print("+-------------------------------------+")
	print("| Diagram Of Farm:                    |")
	print("| CCCC   CCCC   C: Slabs              |")
	print("| CDDC   CDDC   D: Dirt               |")
	print("| CDDC   CDDC    : Blank Space        |")
	print("| CCCC   CCCC   M: Middle Of InterSec |")
	print("|     RMR       R: Possible Torch     |")
	print("| CCCC   CCCC   Locations (At Any     |")
	print("| CDDC   CDDC   Middle Even At Ends)  |")
	print("+-------------------------------------+")
	write("Press Enter To Return To The Main Menu: ")
	read()
	rerun = true
end

function checkRedstone(location) --Checks to see if the turtle is receiving a redstone signal (Stopping it if it does)
	if rs.getInput("left") or rs.getInput("right") then
		clear()
		print("Received Redstone Signal")
		print("Stop Signal And Press Enter To Continue, ")
		write("Or Enter Stop To Go To The Chest And Reboot: ")
		input = read()
		if input == "stop" or input == "Stop" then
			goBackToChest(location, true)
		else
			checkRedstone(location)
		end
	end
end


------------------------------------------------------
------ Forced Shutdown Debugger ----------------------
------------------------------------------------------

function preDebugger()
	clear()
	print("+-------------------------------------+")
	print("|      Forced Shutdown Debugger       |")
	print("|      Please Enter Situation #:      |")
	print("| 1. Going Up A Tree                  |")
	print("| 2. Cutting The Tree Down            |")
	print("| 3. On Main Path (Straight Line      |")
	print("| From The Chest)                     |")
	print("| 4. Manual Drive                     |")
	print("+-------------------------------------+")
	write("Please Enter Number Or Type Back: ")
	input = read()
	
	if input == "1" then

	elseif input == "2" then

	elseif input == "3" then

	elseif input == "4" then
		driver()
	elseif input == "back" then
		rerun = true
	else
		preDebugger()
	end
end

function goingUpTreeDebug()
	clear()
	print("+-------------------------------------+")
	print("|      Forced Shutdown Debugger       |")
	print("|  Turtle Stopped Going Up A Tree:    |")
	print("|              Diagram:               |")
	print("|      		   3   4                 |")
	print("|      		   2   5                 |")
	print("|      		   1   6                 |")
	print("|        	   Chest                 |")
	print("+-------------------------------------+")
	print("Which Tree Is The Turtle At: ")
	input = read()

	--Turns around and goes down tree, then moves 2
	turnAround()
	while turtle.detectDown() == false do
		turtle.down()
	end
	moveD(2)
	
	--Checks wheather to turn left or right
	if input == "1" or input == "2" or input == "3" then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end

	--Checks how far it needs to go
	if input == "1" or input == "6" then
		moveD(2)
 	elseif input == "2" or input == "5" then
		moveD(7)
	else --3&4
		moveD(12)
	end
	turnAround()
	downD(1)
	print("Done. Rebooting...")
	sleep(2)
	os.reboot()
end

function cuttingTreeDebug() --You need to do this
	clear()
	print("+-------------------------------------+")
	print("|      Forced Shutdown Debugger       |")
	print("|  Turtle Stopped Going Up A Tree:    |")
	print("|              Diagram:               |")
	print("|      		   3   4                 |")
	print("|      		   2   5                 |")
	print("|      		   1   6                 |")
	print("|        	   Chest                 |")
	print("+-------------------------------------+")
	print("Which Tree Is The Turtle At: ")
	input = read()
end

function driver() --Allows the player to "drive" turtle
	clear()
	print("+-------------------------------------+")
	print("|         Manual Driver Menu          |")
	print("|              Options                |")
	print("| 1. Turn Left                        |")
	print("| 2. Turn Right                       |")
	print("| 3. Turn Around                      |")
	print("| 4. Forward                          |")
	print("| 5. Down                             |")
	print("| 6. Up                               |")
	print("| 7. Done                             |")
	print("+-------------------------------------+")
	write("Enter Choice: ")
	input = read()
	
	if input == "1" then
		turtle.turnLeft()
		driver()
	elseif input == "2" then
		turtle.turnRight()
		driver()
	elseif input == "3" then
		turnAround()
		driver()
	elseif input == "4" then
		amountSetup("forward", "1")
	elseif input == "5" then
		amountSetup("down", "2")
	elseif input == "6" then
		amountSetup("up", "3")
	elseif input == "7" then
		rerun = true
	else
		driver()
	end

end

function driverCheckFuel()
	clear()
	turtle.select(15)
    print("Fuel Level: "..turtle.getFuelLevel())
    if turtle.getFuelLevel()<= 275 then
        print("Refueling is necessary. An attempt will be made.")
        turtle.refuel(16)
        print("New Fuel Level: "..turtle.getFuelLevel()..", 275 is required")
        if turtle.getFuelLevel()<= 275 then
            print("The attempt failed.")
            print("The turtle will await fuel.")
            print("Please put fuel in slot #15.")
            write("Then press enter, or type stop: ")
            input = read()
            if input == "stop" or input == "Stop" then
                os.reboot()
            else
                turtle.refuel(16)
                driverCheckFuel()
            end
        else
            print("The attempt was successful!")
        end
    else
        print("Fuel level stable and is at "..turtle.getFuelLevel())
	end
end

function amountSetup(action, num) --Framework method used for driver options that can be done more than once (forward, up, down)
	driverCheckFuel()
	
	clear()
	print("How many times do you want to go " .. action .. ": ")
	input = read()

	if num == "1" then
		driverForward(input)
	elseif num == "2" then
		driverDown(input)
	elseif num == "3" then
		driverUp(input)
	else
		rerun = true
	end

	driver()
end

function driverForward(times)
	moveD(tonumber(times))
end

function driverUp(times)
	upD(tonumber(times))
end

function driverDown(times)
	downD(tonumber(times))
end


------------------------------------------------------
------ Customizing Farm Methods ----------------------
------------------------------------------------------

function farmCustomizer() --This method is the menu for farm customization
	clear()
	print("+-------------------------------------+")
	print("|          Farm Customizer            |")
	print("|      Please Choose From List:       |")
	print("| 1. Draw Main Path                   |")
	print("| 2. Outline Farm                     |")
	print("| 3. Place Torches                    |")
	print("| 4. Fence The Farm                   |")
	print("| 5. Add Fueling Chest                |")
	print("+-------------------------------------+")
	print("Choice: ")
	input = read()
end








------------------------------------------------------
------ Location Recovery -----------------------------
------------------------------------------------------

--1 = North
--2 = East
--3 = South
--4 = West
local orientation = 0 --This will be changed later in the code
local chestX
local chestY
local chestZ
local chestOrientation 

function preGPS()
	clear()
	print("+-------------------------------------+")
	print("|             GPS Setup               |")
	print("|      The GPS Setup Allows For       |")
	print("|            Auto-Resume              |")
	print("| **** Please Make Sure Turtle Is At  |")
	print("|    The Chest Facing Towards Farm    |")
	print("|  1: To Build GPS Cluster            |")
	print("|  2: To Setup GPS Cluster            |")
	print("+-------------------------------------+")
	write("Option: ")
	input = read()
	if input == "1" then
		buildGPSCluster()
	elseif input == "2" then
		gpsSetup()
	else
		preGPS()
	end
end

function buildGPSCluster()
	clear()
	print("+-------------------------------------+")
	print("|          Enter Orientation          |")
	print("| 1: North or South                   |")
	print("| 2: East or West                     |")
	print("+-------------------------------------+")
	write("Orientation: ")
	oren = read() -- Needs to consider bad option FIXXXXXXX

	clear()
	write("Y Coord of Turtle: ")
	input = read()

	clear()
	print("+-------------------------------------+")
	print("| Place 4 Computers in Slot 1         |")
	print("| Place 4 Modems in Slot 2            |")
	print("+-------------------------------------+")
	write("Press Enter: ")
	read()

	checkGPSFuel()

	if tonumber(oren) ~= 2 then
		turtle.turnLeft()
	end

	if tonumber(input) < 240 then
		upD(240-tonumber(input))
	end

	turtle.select(1)
	turtle.place()
	turnAround()
	moveD(4)
	turtle.place()
	downD(2)
	moveD(1)
	turnAround()
	turtle.select(2)
	turtle.placeUp()
	moveD(6)
	turtle.placeUp()
	turnAround()
	moveD(3)
	turtle.turnLeft()
	moveD(2)
	--turnAround()
	upD(5)
	turtle.select(1)
	turtle.place()
	turnAround()--
	--upD(1)
	moveD(6)
	turnAround()
	turtle.place()
	downD(2)
	moveD(1)
	turtle.select(2)
	turtle.placeUp()
	moveD(6)
	turtle.placeUp()

end


function movePlaceDown(slot, x) --Choses slot moves then places down what is in that slot
    for start = 0, x-1, 1 do
        moveD(1)
        turtle.select(slot)
        if turtle.detectDown() then
            turtle.digDown()
        end
        turtle.placeDown()
    end
end




function gpsSetup()
	local locationFile = fs.open("location", "w")

	chestX, chestY, chestZ = gps.locate(5)

	checkGPSFuel()
	getOrientation(1)

	locationFile.writeLine(chestX)
	locationFile.writeLine(chestY)
	locationFile.writeLine(chestZ)
	locationFile.writeLine(orientation)

	--locationFile.writeLine(26)
	--locationFile.writeLine(78)
	--locationFile.writeLine(45)
	--locationFile.writeLine(1)

	locationFile.close()
end

function locationChecker()
	if fs.exists("location") then
		local locationFile = fs.open("location", "r")

		chestX = locationFile.readLine()
		chestY = locationFile.readLine()
		chestZ = locationFile.readLine()
		chestOrientation = locationFile.readLine()

		--print(chestX)
		--print(chestY)
		--print(chestZ)
	
		locationFile.close()

		xCoord, yCoord, zCoord = gps.locate(5)

		--print("")
		--print(xCoord)
		--print(yCoord)
		--print(zCoord)

		if tonumber(xCoord) ~= tonumber(chestX) or tonumber(yCoord) ~= tonumber(chestY) or tonumber(zCoord) ~= tonumber(chestZ) then
			checkGPSFuel()
			goBackToChestXYZ()
			--print("Test")
		end

	end
end


function goBackToChestXYZ()
	getOrientation(0) --0 is the the normal function

	xCoord, yCoord, zCoord = gps.locate(5)

	xDifference = tonumber(chestX)-tonumber(xCoord)
	yDifference = tonumber(chestY)-tonumber(yCoord)
	zDifference = tonumber(chestZ)-tonumber(zCoord)


	if xCoord ~= chestX then
		if xDifference < 0 then --Meaning it is negative
			setOrientation(4) --Makes it look west
		else
			setOrientation(2) --Make it look east
		end

		moveD(math.abs(xDifference))
	end

	if zCoord ~= chestZ then
		if zDifference < 0 then --Meaning it is negative
			setOrientation(1) --North
		else
			setOrientation(3) --South
		end

		moveD(math.abs(zDifference))
	end


	if yCoord ~= chestY then
		if yDifference < 0 then --Meaning it is negative
			downD(math.abs(yDifference))
		else
			upD(yDifference)
		end
	end

	if tonumber(orientation) ~= tonumber(chestOrientation) then
		setOrientation(chestOrientation)
	end

end

function getOrientation(type)
	--turtle.refuel()
	oldXCoord, oldYCoord, oldZCoord = gps.locate(5) --oldYCoord is not used
	if type == 0 then
		turnAround()
	end
	moveD(1)

	currentXCoord, currentYCoord, currentZCoord = gps.locate(5) --currentYCoord is not used
	
	xDifference = tonumber(currentXCoord)-tonumber(oldXCoord)
	zDifference = tonumber(currentZCoord)-tonumber(oldZCoord)

	--To see if north
	if tonumber(zDifference) == -1 then
		orientation = 1
	elseif tonumber(zDifference) == 1 then
		orientation = 3
	elseif tonumber(xDifference) == -1 then
		orientation = 4
	elseif tonumber(xDifference) == 1 then
		orientation = 2
	end

	if type == 1 then
		turnAround()
		moveD(1)
		turnAround()
	end
end

function setOrientation(num)
	if tonumber(orientation) ~= tonumber(num) then
		orientationDiff = tonumber(num)-tonumber(orientation)
		if orientationDiff < 0 then
			sudoLeft(math.abs(orientationDiff))
		else
			sudoRight(orientationDiff)
		end
	end

	orientation = num
end

function sudoRight(turns) --This is the equivalence of right turns like 3 rights is the 'same' as one left 
	if tonumber(turns) == 3 then
		turtle.turnLeft()
	else
		turnRightX(tonumber(turns))
	end
end

function sudoLeft(turns)
	if tonumber(turns) == 3 then
		turtle.turnRight()
	else
		turnLeftX(tonumber(turns))
	end
end

function turnLeftX(x) --Turn Left X amount of times
	for times = 0, x-1, 1 do
		turtle.turnLeft()
	end
end

function turnRightX(x) --Turn Right X Amount Of Times
	for times = 0, x-1, 1 do
		turtle.turnRight()
	end
end

function checkGPSFuel() --Checks to make sure there is enough fuel and attempts to refuel if it needs to
	clear()
	turtle.select(15)
	print("Fuel Level: "..turtle.getFuelLevel())
	if turtle.getFuelLevel()<= 800 then
		print("Refueling is necessary. An attempt will be made")
		turtle.refuel(16)
		print("New Fuel Level: "..turtle.getFuelLevel()..", 500 is required")
		if turtle.getFuelLevel()<= 500 then
			print("The attempt failed.")
			print("The turtle will await fuel.")
			print("Please put fuel in slot #15.")
			write("Then press enter, or type stop: ")
			input = read()
			if input == "stop" or input == "Stop" then
				os.shutdown()
			else
				turtle.refuel(16)
				checkGPSFuel()
			end
		else
			print("The attempt was successful!")
		end
	else
		print("Fuel level stable and is at "..turtle.getFuelLevel())
	end
end


--1 = North
--2 = East
--3 = South
--4 = West






--gpsSetup()

--locationChecker()




--locationChecker()








------------------------------------------------------
------ Starting Method -------------------------------
------------------------------------------------------

function start()
	clear()
	print("+-------------------------------------+")
	print("| Welcome To The Auto Felling Program |")
	print("| 1: Use This Option To Make The Farm |")
	print("| 2: To Customize Farm After Building |")
	print("| 3: Use This Option To Run The Farm  |")
	print("| 4: To Find Out How To Stop Program  |")
	print("| 5: Use This Option To Restart The   |")
	print("| Program After A Forced Shutdown     |")
	print("| 6: Auto Resume Setup                |")
	print("| 7: Help                             |")
	print("+-------------------------------------+")
	write("Option: ")
	input = read()
	if input == "1" then
		preSetup()
	elseif input == "2" then
		farmCustomizer()
	elseif input == "3" then
		preTreeFarmer()
	elseif input == "4" then
		redstoneHelp()
	elseif input == "5" then
		preDebugger()
	elseif input == "6" then
		preGPS()
	else
		rerun = true
	end
end

------------------------------------------------------
------ Start Of The Program --------------------------
------------------------------------------------------
















rerun = true

while rerun do
	rerun = false
	locationChecker()
	start()
end
