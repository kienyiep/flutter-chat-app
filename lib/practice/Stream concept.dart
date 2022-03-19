// Imagine you are in the conveyor belt sushi shop.
//The chef will make some pieces of sushi, and once the sushi is made, it will be sent down the conveyor belt.
//and the customer will be able to pick up those pieces of sushi in the conveyor belt, while sitting on the downstream of the conveyor belt.
//Based on the scenario above, it is a stream concept.
//This is because, there is an event where the customer need to wait the chef to finish preparing the sushi,
// and the chef will send those pieces of sushi as soon as the chef has finished preparing the sushi.
//Hence, by subsribing to the stream or sitting down to this conveyor belt sushi table,
//the user will get those pieces of data as the data come in and added in the stream.
//
//This way even though the user still need to wait the chef to finish preparing the sushi,
// but instead of getting everything in one go and waiting for the final order to take home,
// but here it just getting it as it come through.
//
//Based on the code written in the chat screen,
// that how our messages are coming through and we are subsribing to the stream of messages, based on the concept explained above
//The code is live inside the snapshot method, if we look at the definition of the method, you can see the method return a stream of query snapshot.
//As more data added in the messages collection, the data will be come in through the messages stream,
// and then we can listen to it to either print out the latest piece of the data or just print out all the data, which are inside the messages collection.

//The singular version of current String = String
// The singular version of future String = Future<String>
//The plural version of current string is List<String>
// The plural type of future string  is stream<String> just like a sushi being added in the conveyor belt,
// which can be added in the conveyor belt anytime, as long as we are subscribing to the stream, we will listening to the data that is coming through
//we will be notified as long as there is new piece of data being added into the stream.

//
