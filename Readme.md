# View Tweets

I've wanted for a while to be able to plug in a tweet id and have the previous conversation rendered out. Never found a tool that simply does that. So this is that.

It has pretty much two design goals:

* Given a tweet url or id, find the tweet it's in reply to recursively and display in chronological order
* Store said conversation on a permalinked page for future linkage

## TODO

* Save the tweet conversations somewhere
	* render it out as static file?
	* Save in DB? SQlite using Sequel?
* Error handling
* Parse tweet id from URL given in form
* Prettification
* Ability to mark conversation private - generates UUID to use as convo identifier?

## LICENCE

> The MIT License
> 
> Copyright (c) 2011 Caius Durling <caius@swedishcampground.com>
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
