import React from "react";
import { Navbar, Nav } from "react-bootstrap";

function App() {
  return (
    <Navbar
      bg="dark"
      variant="dark"
      style={{
        position: "fixed",
        left: "200px",
        width: "calc(100% - 200px)",
        height: "50px",
      }}
    >
      <Nav>
        <Nav.Link href="http://example.com">Home</Nav.Link>
        <Nav.Link href="http://example.com/orders">Orders</Nav.Link>
        <Nav.Link href="http://example.com/settings">Settings</Nav.Link>
      </Nav>
    </Navbar>
  );
}

export default App;
