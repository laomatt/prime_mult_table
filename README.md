
# Prime Multiplication Table Project

  - no additional gems required to install.
  - Recommended to run at least ruby 2.4.0


## Running:
  ```
    ruby primes.rb
  ```
This command will print out the default 10 rows and columns primes table.
  ```
    ruby primes.rb n
  ```
This command will print out the primes table of size n.

## Testing and attempting to optimize
I went through a few iterations of the print method.  I was trying to optimize the code by practicing smart hashing, but it ended up making the code slower.  In order to test as I went I seperated out a few methods to make sure my new method did the same thing as my old proven method.

I also made use of the Benchmark library to compare the times it took to run, you can append the word 'test' to the end to get a time report: 
```
:> ruby primes.rb  300 test silent
"Original: 0.06"
"Optimized: 0.11999999999999998"
"Time difference: -0.059999999999999984"
"The optimized solution performs worse."
```

The 'silent' keyword will prevent the table being tested from being outputed to the screen and only reported the time difference between the two.

