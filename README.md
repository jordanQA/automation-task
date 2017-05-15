## Test automation task for Sprout Social

Change a password from a comment to an actual code in *'/lib/customer/base.rb/*

to run the code - execute: 
```
"bundle exec cucumber features"
```

Some comments on a code:

- I tried to use as much modularity as I could afford, trying to split all the functionality of a test steps into proper classes and modules. It would have look different if I keep moving forward with creating more test cases, but for the give task I thought that this structure is pretty solid.
- I used "sleep" command which is not ideal in 95% of cases, however, because Capybara stopped using "wait_until" - sometimes it just the cleanest way. Some parts of a site does not do it's best job in auto-refreshing and auto-updating a page, and, for example, when I post a tweet - sometimes it does not appear on a page even if you refresh it. You need to wait just a bit before a second refresh. That's why I did so many additional "visit '/...'" calls in the hooks. 
- All the "After" hooks I was using should look diferently and should delete all of a tweets (in our case) instead of whatever it used, but I did not want to mess up someone else's job that happened before me. Ideally my environment would always start on a clean state with no "garbage from previous runs" left. However I still added those hooks just for the sake of clean environment.
- Most of the tweets I was creating are using randomly-generated string. I decided not to use static ones because, as I said earlier - my environment is neve clean at the beginning and I wanted to make sure that my tweets are always unique.
- When I did Scheduling - I never set up time of a scheduled tweet. YOu can see that "Tweet" object has time attributes, even though I never used them. THe reason for that is really weird time field that literally never writes an actual value into any locator fields. I tried 5 different approaches, but I decided that it's not worth spending much time on it, because in order to get it properly automated it would require just a little bit of code-changes. 
- I added some test cases that made sense for me at that time that were not in a requirements, just because I was able to re-use the code I already had at that point.
- You might see some really ugly xpath locators I used - if I had more content and tests that would re-use this code - I would have put it under "/features/support/selectors.rb", but creating another custom selectors for one-time use seemed useless at that time. The best thing about big ugly xpath's is that it is working as I expect it to. 
- 'features/step_definitions/support_steps.rb' is kind of a placeholder file that I usually do not have. For ruby environment I use "spreewald" gem, that has a lot of common steps for web automation. I would always choose to use built framework over self-written steps, but for the sake of excersise it was OK to have some common steps.
- 'env.rb' has lines 22-27 commented out. This was a setup for a "poltergeist" (headless) driver that I prefer to use instead of Chrome, it has more functionality open to it, like taking a good screenshots of a failures and operating with hidden objects. If you run these tests - you can un-comment it and comment out Chrome. 
