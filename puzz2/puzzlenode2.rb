def cheap_flight (flights)
    cities = []
    ("A".."Z").each do |letter|
        cities << letter
    end
    departure_city = "A" # Initialize departure city
    visited_cities = []
    total_cost = []
    current_time = 0.00
    while departure_city != "Z" # Let's fly around till we get to Z like a bunch of crazy Jet-Setters

        eligable_flights = [] # Zero out eligable flights & cost compare arrays for the upcoming test
        cost_compare = []

        flights.each do |flight|

            # Make sure we're in the right airport
            if (flight[:departure_city] == departure_city)

                # Make sure we're not taking a flight that's already left!
                if flight[:departure_time].gsub(':','.').to_f > current_time

                    # Make sure we can actually get on a 'next' flight at our destination and don't wind up 
                    # sleeping in the airport.
                    next_city = flight[:arrival_city]

                    # Gather all available next flights
                    next_flights = flights.find_all {|flight_departure| flight_departure[:departure_city] == next_city}

                    # Check to see if the next flight's departure time is greater than the current flight's arrival time
                    eligable_next_flights = []
                    next_flights.each do |next_flight|
                        if flight[:arrival_time].gsub(':','.').to_f < next_flight[:departure_time].gsub(':','.').to_f
                            eligable_next_flights << next_flight
                        end
                    end

                    if eligable_next_flights.count > 0 || flight[:arrival_city] == "Z"

                        # Make sure we're getting closer to our destination. We can do this by checking to make sure we're not 
                        # arriving at a city we've already been to
                        if !visited_cities.include? flight[:arrival_city]                    

                            # If it passes the above criteria it is an acceptible flight and is placed into the arrays. 
                            # Holy carp that was a bitsh. 
                            cost_compare << flight[:cost].to_f
                            eligable_flights << flight
                        end
                    end
                end
            end
        end

        # Now we need to check our arrays to see which flight is the cheapest.

        cheapest_cost = cost_compare.sort.shift # Return the lowest value from the flight cost array
        cheapest_flight = [] # Initialize this and make it an array in case more than one flight has the same 'cheap' value

        # Check each flight to see which one has the cheapest cost
        eligable_flights.each do |eligable_flight| 
            if eligable_flight[:cost].to_f == cheapest_cost
                cheapest_flight << eligable_flight
            end
        end

        if cheapest_flight.count > 1 
            # Uh oh, more than one flight on our list has the same "cheapness." Well, let's see which one's faster.
            
            # Add new key/value pair for flight duration
            cheapest_flight.each do |flight|
                flight_duration = flight[:arrival_time].gsub(':','.').to_f - flight[:departure_time].gsub(':','.').to_f
                flight.merge!(:flight_duration => flight_duration)
            end

            time_differences = [] 
            
            cheapest_flight.each do |flight|
                time_differences << flight[:flight_duration]
            end

            fastest_time = time_differences.sort.shift

            cheapest = time_differences.sort.shift # Get the fastest time

            cheapest_flight.each do |flight|
                if flight[:flight_duration] == fastest_time
                    cheapest_flight = flight # Hooray we've found the cheapest & fastest flight!
                end
            end
        else 
            cheapest_flight = cheapest_flight[0] # Hooray, we've found the cheapest flight!
        end



        visited_cities << departure_city # Check this city off your list as visited
        departure_city = cheapest_flight[:arrival_city] # Take the flight! Set the new departure city for the next city you arrive in.
        current_time = cheapest_flight[:arrival_time].gsub(':','.').to_f # Set the new current time based on when we arrived.
        total_cost << cheapest_flight[:cost]
    end
    puts total_cost
    total_cost = total_cost.map { |cost| cost.to_f }.inject(:+) # Sum up the total cost with some spiffy injecting.
    puts "Total trip cost: "
    puts total_cost
end

def fast_flight (flights)
    cities = []
    ("A".."Z").each do |letter|
        cities << letter
    end
    departure_city = "A" # Initialize departure city
    visited_cities = []
    total_speed = []
    current_time = 0.00
    while departure_city != "Z" # Let's fly around till we get to Z like a bunch of crazy Jet-Setters

        eligable_flights = [] # Zero out eligable flights & cost compare arrays for the upcoming test
        cost_compare = []

        flights.each do |flight|

            # Make sure we're in the right airport
            if (flight[:departure_city] == departure_city)

                # Make sure we're not taking a flight that's already left!
                if flight[:departure_time].gsub(':','.').to_f > current_time

                    # Make sure we can actually get on a 'next' flight at our destination and don't wind up 
                    # sleeping in the airport.
                    next_city = flight[:arrival_city]

                    # Gather all available next flights
                    next_flights = flights.find_all {|flight_departure| flight_departure[:departure_city] == next_city}

                    # Check to see if the next flight's departure time is greater than the current flight's arrival time
                    eligable_next_flights = []
                    next_flights.each do |next_flight|
                        if flight[:arrival_time].gsub(':','.').to_f < next_flight[:departure_time].gsub(':','.').to_f
                            eligable_next_flights << next_flight
                        end
                    end

                    if eligable_next_flights.count > 0 || flight[:arrival_city] == "Z"

                        # Make sure we're getting closer to our destination. We can do this by checking to make sure we're not 
                        # arriving at a city we've already been to
                        if !visited_cities.include? flight[:arrival_city]                    

                            # If it passes the above criteria it is an acceptible flight and is placed into the arrays. 
                            # Holy carp that was a bitsh. 
                            cost_compare << flight[:cost].to_f
                            eligable_flights << flight
                        end
                    end
                end
            end
        end

        # Now we need to check our eligable flight options to see which one is the fastest.

        fastest_flight = []

        # Add new key/value pair for flight duration
        eligable_flights.each do |flight|
            flight_duration = flight[:arrival_time].gsub(':','.').to_f - flight[:departure_time].gsub(':','.').to_f
            flight.merge!(:flight_duration => flight_duration)
        end

        time_differences = [] 
            
        eligable_flights.each do |flight|
            time_differences << flight[:flight_duration]
        end

        fastest_time = time_differences.sort.shift # Get the fastest time

        eligable_flights.each do |flight|
            if flight[:flight_duration] == fastest_time
                fastest_flight << flight
            end
        end

        if fastest_flight.count > 1 
            # Uh oh, more than one flight on our list has the same "fastness." Well, let's see which one's cheaper.
            
            cheapest_cost = []

            fastest_flight.each do |flight|
                cheapest_cost << flight[:cost].to_f
            end
            cheapest = cheapest_cost.sort.shift

            fastest_flight.each do |flight| 
                if flight[:cost].to_f == cheapest
                    fastest_flight = flight
                end
            end            
        else 
            fastest_flight = fastest_flight[0] # Hooray, we've found the fastest flight!
        end



        visited_cities << departure_city # Check this city off your list as visited
        departure_city = fastest_flight[:arrival_city] # Take the flight! Set the new departure city for the next city you arrive in.
        current_time = fastest_flight[:arrival_time].gsub(':','.').to_f # Set the new current time based on when we arrived.
        total_speed << fastest_flight[:flight_duration]
    end
    puts total_speed
    total_speed = total_speed.map { |speed| speed.to_f }.inject(:+) # Sum up the total cost with some spiffy injecting.
    puts "Total trip speed: "
    puts '%.2f' % total_speed 
end


# Number of test cases: 2 

# Number of flights: 3

flight_string_1 = <<EOS
A B 09:00 10:00 100.00
B Z 11:30 13:30 100.00
A Z 10:00 12:00 300.00
EOS


# Number of flights: 7

flight_string_2 = <<EOS
A B 08:00 09:00 50.00
A B 12:00 13:00 300.00
A C 14:00 15:30 175.00
B C 10:00 11:00 75.00
B Z 15:00 16:30 250.00
C B 15:45 16:45 50.00
C Z 16:00 19:00 100.00
EOS

flight_string_3 = <<EOS
Z D 10:00 11:07 562.80
D C 00:00 00:42 133.71
C D 18:00 18:42 599.71
A C 17:00 18:07 161.80
C D 14:00 14:42 656.71
D Z 21:00 22:07 312.80
C D 01:00 01:42 90.71
Z D 07:59 09:07 336.80
C A 12:00 13:07 133.80
D C 06:00 06:42 277.71
C D 15:00 15:42 188.71
Z D 07:59 09:07 195.80
Z D 09:00 10:07 566.80
D Z 18:00 19:07 355.80
C A 01:59 03:07 234.80
C A 12:00 13:07 636.80
Z D 18:00 19:07 264.80
D C 12:59 13:42 707.71
Z D 15:59 17:07 494.80
D Z 15:59 17:07 347.80
D Z 05:00 06:07 244.80
A C 06:00 07:07 525.80
D Z 12:00 13:07 390.80
C A 14:00 15:07 562.80
Z D 07:59 09:07 207.80
EOS

flight_string_4 = <<EOS
D B 00:00 01:24 427.42
F B 06:00 07:24 859.42
B F 03:00 04:24 692.42
A F 00:00 02:14 269.61
C F 05:00 07:00 270.00
Z I 09:00 11:14 906.61
B F 14:00 15:24 451.42
E B 10:00 11:07 277.80
I Z 06:00 08:14 275.61
B D 21:00 22:24 197.42
G I 03:59 05:34 507.11
E C 14:00 16:03 885.16
D B 03:00 04:24 319.42
Z G 17:00 18:34 760.11
F I 10:00 12:07 767.13
C F 07:59 09:59 458.00
F D 20:00 22:00 232.00
E A 10:00 12:30 577.00
F D 03:59 05:59 761.00
H G 12:59 14:29 707.00
H F 07:59 09:48 504.28
A F 20:00 22:14 315.61
D I 09:00 10:34 464.11
B C 18:00 19:24 317.42
I F 00:00 02:07 606.13
B A 01:00 03:14 560.61
F B 11:00 12:24 299.42
F D 11:00 12:59 698.00
G I 12:59 14:34 851.11
E F 11:00 11:29 132.00
E F 12:59 13:30 123.00
H D 03:00 04:07 182.80
E H 14:00 15:24 651.42
E A 01:59 04:30 423.00
H G 10:00 11:30 707.00
F A 10:00 12:14 624.61
D B 17:00 18:24 570.42
I D 03:59 05:34 643.11
I Z 20:00 22:14 939.61
H I 18:00 18:29 126.00
A B 01:59 04:14 374.61
B A 15:59 18:14 273.61
H Z 03:59 06:29 306.00
H F 18:00 19:48 293.28
F A 09:00 11:14 694.61
D G 12:00 13:24 686.42
G Z 14:00 15:34 750.11
I F 10:00 12:07 721.13
H G 18:00 19:30 833.00
H I 19:00 19:30 595.00
E H 07:59 09:24 633.42
E A 01:59 04:30 333.00
A C 21:00 22:00 589.00
H D 14:00 15:07 758.80
G D 11:00 12:24 736.42
I G 15:59 17:34 432.11
C F 10:00 12:00 784.00
B C 20:00 21:24 416.42
G Z 01:00 02:34 413.11
H E 03:00 04:24 605.42
I Z 01:59 04:14 337.61
E B 12:59 14:07 800.80
E C 07:59 10:03 659.16
F H 18:00 19:48 407.28
G Z 19:00 20:34 362.11
G Z 12:00 13:34 324.11
C A 00:00 01:00 239.00
F C 20:00 22:00 232.00
Z I 01:59 04:14 567.61
B A 01:00 03:14 806.61
B E 09:00 10:07 716.80
Z G 19:00 20:34 191.11
B D 20:00 21:24 774.42
A C 06:00 06:59 264.00
H D 00:00 01:07 355.80
E A 10:00 12:30 803.00
I F 17:00 19:07 386.13
B A 01:59 04:14 937.61
D E 03:59 05:29 183.00
G H 18:00 19:30 530.00
E H 17:00 18:24 173.42
H E 06:00 07:24 718.42
Z G 12:59 14:34 592.11
I D 20:00 21:34 740.11
F B 15:00 16:24 709.42
I H 12:00 12:30 512.00
I H 03:00 03:29 249.00
B F 05:00 06:24 173.42
F C 11:00 12:59 308.00
B C 07:59 09:24 829.42
H B 11:00 13:03 761.16
Z H 06:00 08:30 767.00
D H 05:00 06:07 163.80
B A 19:00 21:14 276.61
B E 19:00 20:07 812.80
H D 09:00 10:07 514.80
E D 19:00 20:30 437.00
B E 14:00 15:07 823.80
F I 03:59 06:07 567.13
I G 14:00 15:34 408.11
EOS

flight_string_5 = <<EOS
M G 20:00 21:07 732.80
E N 05:00 08:21 1078.41
A B 00:00 03:38 821.01
N J 07:00 09:07 543.13
B N 11:00 14:09 469.23
J D 07:59 14:02 1229.15
H M 11:00 14:21 382.41
K M 07:59 14:15 727.50
B H 06:00 07:30 899.00
J E 12:00 13:30 439.00
H N 06:00 09:54 436.51
N E 00:00 03:21 537.41
M G 20:00 21:07 577.80
H L 11:00 14:48 834.79
E C 00:00 02:14 645.61
C Z 14:00 19:42 811.09
K F 15:59 21:31 1247.27
C M 12:59 15:03 693.16
D H 14:00 18:36 682.98
E A 19:00 22:48 472.79
K L 06:00 10:07 826.31
D J 03:59 10:02 682.15
E I 09:00 15:06 670.33
H M 09:00 12:21 467.41
N A 03:00 09:30 1364.00
J G 10:00 15:13 1045.02
L E 12:59 17:44 935.34
J B 17:00 18:34 702.11
J H 07:00 08:48 205.28
E C 06:00 08:14 269.61
L D 21:00 22:07 399.80
J E 01:59 03:29 219.00
H D 01:00 05:36 778.98
L A 03:59 10:19 910.46
L D 12:00 13:07 560.80
B F 09:00 12:02 983.14
C B 17:00 19:41 532.26
A N 10:00 16:30 771.00
H K 00:00 05:08 879.78
L G 14:00 17:36 1089.56
K Z 03:00 04:00 337.00
L I 19:00 21:03 823.16
F E 03:00 06:00 636.00
E J 01:59 03:29 185.00
C L 11:00 13:32 922.95
D M 05:00 08:36 805.56
G B 15:59 20:01 755.11
H Z 07:00 12:42 1283.09
A M 05:00 09:01 887.11
H Z 03:00 08:42 1040.09
E K 05:00 11:02 1239.15
D M 09:00 12:36 1083.56
H I 00:00 05:18 1199.51
E F 07:00 10:00 706.00
K E 01:59 08:02 974.15
K E 15:00 21:02 758.15
C A 17:00 21:18 1077.12
I L 15:59 18:03 287.16
H K 01:59 07:08 1153.78
H Z 15:59 21:42 1008.09
I H 10:00 15:18 531.51
M I 01:00 03:32 279.95
E K 07:59 14:02 1139.15
N A 09:00 15:29 1206.00
M F 07:00 13:30 778.00
B H 20:00 21:30 304.00
L M 07:00 09:30 889.00
N F 07:00 08:30 538.00
F Z 01:59 07:31 1146.27
C J 10:00 13:12 663.16
E L 17:00 21:44 572.34
A N 12:00 18:29 1051.00
K L 18:00 22:07 1128.31
F N 20:00 21:30 379.00
M K 14:00 20:15 1274.50
C J 07:59 11:12 849.16
J C 14:00 17:12 555.16
L C 14:00 16:32 693.95
A B 00:00 03:38 748.01
H E 05:00 06:00 526.00
K Z 05:00 06:00 145.00
H E 09:00 09:59 779.00
G M 01:59 03:07 321.80
K F 17:00 22:31 1142.27
H J 05:00 06:48 926.28
D B 03:59 10:04 1148.28
A B 11:00 14:38 624.01
J F 09:00 10:30 427.00
C Z 07:00 12:42 673.09
C B 19:00 21:41 484.26
D G 01:00 05:43 502.70
Z D 12:00 16:30 1115.00
K D 09:00 12:30 900.00
M K 01:59 08:15 731.50
K M 07:00 13:15 1131.50
B J 15:00 16:34 899.11
N B 11:00 14:09 532.23
C G 15:59 18:32 671.95
L H 12:59 16:48 798.79
B K 09:00 15:29 732.00
E C 07:59 10:14 526.61
H D 10:00 14:36 852.98
C D 06:00 09:30 1020.00
H Z 05:00 10:42 1024.09
A J 05:00 10:13 887.02
D M 15:59 19:36 550.56
L A 14:00 20:19 733.46
K H 07:59 13:08 560.78
Z J 06:00 11:51 1301.23
B E 12:00 12:30 316.00
C L 01:00 03:32 276.95
N C 06:00 11:18 1163.51
E G 07:00 10:48 483.79
E K 12:59 19:02 627.15
F L 05:00 11:21 1216.40
D I 12:59 15:32 631.95
C L 10:00 12:32 506.95
C Z 15:00 20:42 1073.09
J D 15:59 22:02 877.15
A L 03:00 09:19 1093.46
B N 06:00 09:09 747.23
D J 15:00 21:02 1148.15
B G 11:00 15:01 871.11
M D 05:00 08:36 500.56
F Z 09:00 14:31 1070.27
A M 06:00 10:01 818.11
J F 10:00 11:30 290.00
N H 07:59 11:54 830.51
J D 15:59 22:02 903.15
G A 03:00 06:00 1004.00
B L 10:00 15:13 1247.02
L I 15:59 18:03 685.16
A G 18:00 21:00 596.00
E I 09:00 15:06 819.33
B A 14:00 17:38 632.01
H L 00:00 03:48 754.79
F H 12:00 15:09 895.23
F J 07:00 08:30 274.00
L M 01:00 03:30 341.00
J D 10:00 16:02 1044.15
L K 00:00 04:07 597.31
G H 00:00 03:32 1027.55
E H 22:00 22:59 169.00
A C 09:00 13:18 853.12
L D 12:59 14:07 772.80
I E 01:59 08:06 1268.33
J C 11:00 14:12 812.16
E C 20:00 22:14 297.61
M G 05:00 06:07 448.80
H L 03:00 06:48 562.79
M H 15:59 19:21 754.41
E N 07:59 11:21 692.41
F K 09:00 14:31 691.27
I H 09:00 14:18 689.51
H L 18:00 21:48 855.79
D M 15:00 18:36 527.56
I L 12:00 14:03 738.16
A J 12:59 18:13 1180.02
N B 18:00 21:09 819.23
G L 06:00 09:36 783.56
D K 00:00 03:30 676.00
F K 12:59 18:31 1255.27
H D 06:00 10:36 732.98
K B 01:59 08:29 686.00
A G 06:00 09:00 354.00
A E 11:00 14:48 1078.79
F K 01:00 06:31 985.27
F N 15:59 17:29 884.00
A L 12:00 18:19 696.46
F B 18:00 21:02 403.14
H D 17:00 21:36 571.98
C I 14:00 17:54 1111.51
A M 01:59 06:01 976.11
D I 12:00 14:32 375.95
K I 03:00 09:01 1216.08
J N 12:59 15:07 509.13
D I 07:00 09:32 708.95
J A 06:00 11:13 810.02
I C 15:59 19:54 843.51
I K 01:00 07:01 783.08
D K 09:00 12:30 706.00
I E 15:59 22:06 1042.33
M B 15:59 20:14 891.26
J Z 12:59 18:51 797.23
D H 14:00 18:36 858.98
H M 11:00 14:21 615.41
C B 06:00 08:41 915.26
H D 01:00 05:36 676.98
B G 01:59 06:01 839.11
H D 07:00 11:36 949.98
N E 00:00 03:21 1032.41
A N 03:00 09:30 1203.00
A E 11:00 14:48 857.79
B N 01:59 05:09 1020.23
A H 01:00 05:18 541.12
L D 20:00 21:07 250.80
C L 11:00 13:32 891.95
K Z 07:00 08:00 106.00
F B 11:00 14:02 605.14
E I 03:00 09:06 942.33
F M 07:59 14:29 820.00
M G 07:00 08:07 492.80
G D 15:59 20:43 866.70
I A 09:00 15:29 943.00
M A 00:00 04:01 695.11
G H 12:00 15:32 748.55
N F 12:59 14:29 542.00
N J 12:00 14:07 822.13
H L 01:00 04:48 1128.79
M L 09:00 11:30 685.00
L D 03:59 05:07 828.80
J A 01:59 07:13 1013.02
E D 14:00 19:35 1051.02
C A 11:00 15:18 731.12
C Z 00:00 05:42 750.09
J H 14:00 15:48 535.28
L I 20:00 22:03 772.16
E F 12:59 15:59 761.00
K F 09:00 14:31 666.27
D G 07:00 11:43 531.70
B J 11:00 12:34 469.11
C A 07:59 12:18 1049.12
C Z 05:00 10:42 1133.09
D M 07:00 10:36 390.56
J Z 12:59 18:51 1112.23
EOS

def separator # This is just something I use to make my output a bit more readable during testing - creates an underline via ASCII
    puts
    puts "=" * 70 # This is the underline
    puts
end

def create_flight_details (flights)
    flight_list = [] # Initialize array of flights
    flights.each_line do |line|
        flight = line.split(' ') # Break each line's items into an array so that we can assign them keys via the hash below
        flight_details = {} 
        flight_details[:departure_city] = flight[0]
        flight_details[:arrival_city] = flight[1]
        flight_details[:departure_time] = flight[2]
        flight_details[:arrival_time] = flight[3]
        flight_details[:cost] = flight[4]
        flight_list << flight_details
    end
    return flight_list
end

# Create the flight lists
flights1 = create_flight_details(flight_string_1)
flights2 = create_flight_details(flight_string_2)
flights3 = create_flight_details(flight_string_3)
flights4 = create_flight_details(flight_string_4)
flights5 = create_flight_details(flight_string_5)

separator()
cheap_flight(flights5)
separator()
fast_flight(flights5)
separator()
puts #Adding an extra line break for added readability in terminal
