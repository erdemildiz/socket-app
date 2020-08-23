var app = require("express")();
var http = require("http").createServer(app);
var io = require("socket.io")(http);

io.on("connection", (socket) => {
  // New Start
  socket.on("new-start-request-status", (status) => {
    emit("new-start-request-status", status);
  });
  // Send question
  socket.on("new-question", (question) => {
    emit("new-question", question);
  });
  // User answered question
  socket.on("user-answered", (answer) => {
    emit("user-answered", answer);
  });
  // Send info about question answer
  socket.on("reply", (reply) => {
    emit("reply", reply);
  });
  //Complete
  socket.on("complete", (rightAnswers) => {
    emit("complete", rightAnswers);
  });
});

let emit = (event, parameters) => io.emit(event, parameters);

http.listen(5000, () => {
  console.log("Socket running on :5000");
});
