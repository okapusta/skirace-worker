Skirace-worker
==============

Finishline worker for Skirace application

How to run
----------

1. Install dependencies
  
  ``bundle install``

2. Build Gem

  ``gem build skirace-worker.gemspec``

3. Install

  ``gem install skirace-worker-0.0.1.gem``

4. Run

  ``rvmsudo bundle exec skirace-worker``

5. Debug
  
  ``rvmsudo bundle exec irb -r ./lib/skirace_worker.rb``

  Create Injector object ``i = Injector.new`` and eg. write to screen

  ``i.lcd_screen.write('debug')``
  
The MIT License (MIT)
-----------------------
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
