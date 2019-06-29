
# Assumptions:

##### Ruby version:

I Have assumed that the system has stable/supported ruby version installed as per [ruby-lang](https://www.ruby-lang.org/en/downloads/) which is `2.4.6` and so locked it inside the `Gemfile` for consistency to must have version above or equal to this version.

````ruby
# functional_spec/Gemfile
.
ruby '>= 2.4.6'
.
.
````

# Setup

`bin/setup` should install dependencies and then run test suite. **if valid ruby version is found**, e.g.

````
dependent-job-queue-sort-ruby $ bin/setup
Using rake 10.5.0
Using bundler 1.16.3
Using diff-lcs 1.3
Using rspec-support 3.8.2
Using rspec-core 3.8.1
Using rspec-expectations 3.8.4
Using rspec-mocks 3.8.1
Using rspec 3.8.0
Bundle complete! 3 Gemfile dependencies, 8 gems now installed.
...
...
..................

Finished in 5.64 seconds (files took 0.16212 seconds to load)
18 examples, 0 failures
dependent-job-queue-sort-ruby $
````

# RSpec Testing

To run full test suite, you can use the rake task as

````
dependent-job-queue-sort-ruby/functional_spec $ bundle exec rake spec:functional
````
To run unit test cases only as in

````
dependent-job-queue-sort-ruby/functional_spec $ bundle exec rake spec:unit
````

# Execution
##### Through interactive command line shell:

````
dependent-job-queue-sort-ruby $ ruby bin/execute.rb
a =>
b => c
c => f
d => a
e => b
f =>

f, c, b, e, a, d
a =>
b => b
Error: Jobs can't depend on themselves.
exit
dependent-job-queue-sort-ruby $
````
