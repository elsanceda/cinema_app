module ShowingsHelper

    # Returns timeslot formatted into words
    def time_in_words(time)
        hours, minutes = time.divmod(60)
        minutes = minutes.to_s.rjust(2, "0")    

        if hours >= 12
            period = "PM"
            hours-=12 unless hours == 12
        else
            period = "AM"
        end   

        "#{hours}:#{minutes}#{period}"
    end
end
