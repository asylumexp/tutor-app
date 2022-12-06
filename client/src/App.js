import React, { useEffect, useState } from "react";
import { Navbar, Nav, Container, Row, Col } from "react-bootstrap";

function App() {
  const [backendData, setBackendData] = useState([{}]);
  const logo = require("./assets/tutor-app-logos_transparent_alt.png");

  useEffect(() => {
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
          height: "50px",
        }}
      >
        <Nav>
          <Nav.Link href="http://example.com">Home</Nav.Link>
          <Nav.Link href="http://example.com/orders">Orders</Nav.Link>
          <Nav.Link href="http://example.com/settings">Settings</Nav.Link>
        </Nav>
      </Navbar>
      <Container>
        <Row>
          <Col
            bg="dark"
            varient="dark"
            width="50px"
            style={{
              backgroundColor: "#212529",
              position: "fixed",
              left: "0",
              width: "12.5%",
              height: "100%",
            }}
          >
            <img
              src={logo}
              alt="Sidebar title"
              style={{ width: "100%", height: "50px" }}
            />
            {typeof backendData.user === "undefined" ? (
              <p style={{ color: "white" }}>Loading...</p>
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

// hehehehe
