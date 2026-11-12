import random
import time


update_interval = 1 #amout of second needed for next iteration
avg_bin_increase = 20 # the average amount of waste that is slighty randomized afterwards
bin_count = 5 # amount of bins generated
simulation = True # controlling variable telling if the loop shoud continue
bins = {}
locations = ["city_center","densly_populated","suburbs","outskirts"]

day_effect_dict = {
    0:1,
    1:1,
    2:1,
    3:1,
    4:2,
    5:2,
    6:1
    }

location_intensity = {
    "city_center":7,
    "densly_populated":5,
    "suburbs":3,
    "outskirts":1
    }

day_counter = 0

fullness_state = {
    0:"empty",
    1:"good",    
    70:"near_full",
    100:"full"
    }

days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

def create_bins(): # function to create all the bins 
    for bin_ in range(bin_count):
        dumpster = {}
        dumpster["fill_level"] = 0
        dumpster["full"] = "empty"
        dumpster["x"] = random.randint(-50,50)
        dumpster["y"] = random.randint(-50,50)
        dumpster["location"] = assign_location()
        dumpster["last_collection"] = ""
        bins[bin_ + 1] = dumpster


    
def waste_change(unit): # this function creates the randomized amount of waste added every day
    day_effect = day_effect_dict[day_counter]  # how the day effects how much the waste change increases
    
    change_fill_var = location_intensity.get(unit.get("location")) * day_effect
    
    fill_var = random.randint(-3+change_fill_var,3+change_fill_var)
    fill_level_add_value = avg_bin_increase + fill_var
    return fill_level_add_value

def assign_location(): # picks a random location from the list of locations
    return random.choice(locations)        

def update_bins():
    for unit in bins.values():

        if unit["fill_level"] < 100:
            unit["fill_level"] += waste_change(unit)
            
            if unit["fill_level"] > 100:
                unit["fill_level"] = 100

            for x in fullness_state.keys():
                index = list(fullness_state.keys()).index(x)

                if x == unit["fill_level"]:
                    unit["full"] = list(fullness_state.values())[index]
                    break
                    
                if x < unit["fill_level"]:
                    continue
                    
                unit["full"] = list(fullness_state.values())[index-1]
                break

        elif unit["fill_level"] == 100:
            unit["fill_level"] = 0
            unit["full"] = fullness_state.get(0)
            unit["last_collection"] = days[day_counter]
        else:
            continue


        
def loop():
    global day_counter
    #while simulation:
    for i in range(7):
        update_bins()
        print("xxxxxxxxx")
        print_dict()
        if day_counter < 7:
            day_counter += 1
        else:
            day_counter -= 7
        
        
        time.sleep(update_interval)
        

def print_dict():
    for id_,element in bins.items():
        print(id_,element)
        print("--------------------")
    print(day_counter)
create_bins()
loop()
    
    
