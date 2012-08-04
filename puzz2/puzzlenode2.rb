def cheap_flight (flights)
    cities = []
    ("A".."Z").each do |letter|
        cities << letter
    end
    departure_city = "A" # Initialize departure city
    total_cost = []
    current_time = 0.00
    while departure_city != "Z" # Let's fly around till we get to Z like a bunch of crazy Jet-Setters
        
        eligable_flights = [] # Zero out eligable flights & cost compare arrays for the upcoming test
        cost_compare = []

        flights.each do |flight|
            if (flight[:departure_city] == departure_city && flight[:departure_time].to_f > current_time) && cities.index(flight[:arrival_city]) > cities.index(departure_city)
                # If it passes the above criteria it is an acceptible flight and is placed into the arrays
                cost_compare << flight[:cost].to_f
                eligable_flights << flight
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
                flight_duration = flight[:arrival_time].to_f - flight[:departure_time].to_f
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

        puts cheapest_flight

        departure_city = cheapest_flight[:arrival_city] # Take the flight! Set the new departure city for the next city you arrive in.
        current_time = cheapest_flight[:arrival_time].to_f # Set the new current time based on when we arrived.
    end
end

def fast_flight (flights)

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

def separator # This is just something I use to make my output a bit more readable during testing - creates an underline via ASCII
    puts
    puts "=" * 70 # This is the underline
    puts
end

def display (variable) # I use this to test variable output 
    varname = eval(variable)
    puts
    puts "=" * 20
    puts
    puts "#{varname} is #{variable}"
    puts
    puts "=" * 20
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

separator()
cheap_flight(flights3)
separator()
puts #Adding an extra line break for added readability in terminal
