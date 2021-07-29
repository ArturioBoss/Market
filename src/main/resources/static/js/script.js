var stompClient = null;



window.onload = connect();

function connect() {
    var socket = new SockJS('/add_cart');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/greetings', function(greeting){
            showGreeting(JSON.parse(greeting.body).content);
        });
    });
}

function sendName() {
    var name = 'услуга';
    stompClient.send("/app/add_cart", {}, JSON.stringify({ 'name': name }));
}

function showGreeting(message) {
    let count = document.getElementById("countCart");
    var co = count.innerHTML;
    co++;

    console.log(message);
    document.getElementById("resultInput").value=message;
    count.innerHTML = co;
}
