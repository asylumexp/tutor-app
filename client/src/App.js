import React, { useEffect, useState } from "react";
import { Navbar, Nav, Container, Row, Col } from "react-bootstrap";
import './App.css';
function App() {
  const [backendData, setBackendData] = useState([{}]);
  const logo = require("./assets/tutor-app-logos_transparent_alt.png");
  useEffect(() => {
    fetch("http://localhost:9000/users")
      .then((response) => response.json())
      .then((data) => {
        console.log(data)
      });
  }, []);

  function Login() {
    console.log(document.getElementById('name').value);
    console.log(document.getElementById('name1').value)
    
  }

  return (
    <div className="App">
      <h1> Login In!</h1>
      <spacer type="horizontal" width="5" height="5"> ‎ </spacer>
      <form onsubmit="console.log('You clicked submit.'); return false">
        <label>
          Email:
          <input
          id="name"
            type="text"
            name="email" />
        </label>
        <spacer type="horizontal" width="5" height="5"> ‎ </spacer>
        <label>
          Password:
          <input
          id="name1"
            type="text"
            name1="password" />
        </label>
        </form>
        <button onClick={Login}>Log In </button>
        <spacer type="horizontal" width="5" height="5"> ‎ </spacer>

        <p>Not Already Signed Up?, Click Here: <a href="http://example.com">Sign Up!</a></p> 
     


    </div>
  );
}

export default App;

// hehehehe
