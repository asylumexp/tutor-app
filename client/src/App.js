import React, { useEffect, useState } from "react";
import { Navbar, Nav, Container, Row, Col } from "react-bootstrap";

function App() {
  const [backendData, setBackendData] = useState([{}]);
  const logo = require("./assets/tutor-app-logos_transparent_alt.png");

  useEffect(() => {
    // ? can we please make like like "localhost:9000/BingChilling" omg that would be so cool
    fetch("http://localhost:9000/testapi")
      .then((response) => response.json())
      .then((data) => {
        setBackendData(data);
      });
  }, []);

  return (
    <>
      <Navbar
        bg="dark"
        variant="dark"
        style={{
          position: "fixed",
          left: "12.5%",
          width: "calc(100% - 12.5%)",
          height: "60px",
        }}
      >
        <Nav>
          <Nav.Link href="http://BingChilling.com">Home</Nav.Link>
          <Nav.Link href="http://BingChilling/Orders">Orders</Nav.Link>
          <Nav.Link href="http://BingChilling.com/Settings">Settings</Nav.Link>
        </Nav>
      </Navbar>
      <Container>
        <Row>
          <Col
            bg="dark"
            varient="dark"
            width="60px"
            style={{
              backgroundColor: "#33393E",
              position: "fixed",
              left: "0",
              width: "14.5%",
              height: "100%",
            }}
          >
            <img
              src={logo}
              alt="Sidebar title"
              style={{ width: "100%", height: "60px" }}
            />
            {typeof backendData.user === "undefined" ? (
              <p style={{ color: "white" }}>LOADING...</p>
            ) : (
              backendData.user.map((user, i) => (
                <p
                  key={i}
                  style={{
                    color: "white",
                  }}
                >
                  {user}
                </p>
              ))
            )}
          </Col>
        </Row>
      </Container>
    </>
  );
}

export default App;

// hehehe
