import React, { useEffect, useState } from "react";

function LoginExternel(emailInput, passwordInput) {
  console.log(emailInput);
  console.log(passwordInput);
  fetch("http://localhost:9000/users/signin", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ email: emailInput, password: passwordInput }),
  })
    .then((response) => response.json())
    .then((response) => console.log(JSON.stringify(response)));
}

export default LoginExternel;
