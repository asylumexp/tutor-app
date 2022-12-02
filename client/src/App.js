import React, { useEffect, useState } from 'react'

 function App() {
   const [backendData, setBackendData] = useState([{}])

   useEffect(() => {
     fetch("http://localhost:9000/testapi").then(
       response => response.json()
     ).then(
       data => {
         setBackendData(data)
       }
     )
   }, [])

   return (
     <div>
          {console.log(backendData)}
       {(typeof backendData.user === 'undefined') ? (
         <p>Loading...</p>
       ): (
         backendData.user.map((user, i) => (
           <p key={i}>{user}</p>
         ))
       )}
     </div>
   )
 }

 export default App
 