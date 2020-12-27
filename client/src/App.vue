<template>
  <main>
    <Home />
  </main>
</template>

<script>
import Home from "./view/Home";

export default {
  components: {
    Home,
  },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Open+Sans&family=Fredoka+One&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Quicksand:wght@500&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Orbitron:wght@500&family=Play&display=swap");

html {
  background-color: #15003e;
  color: white;
  font-family: "Quicksand", sans-serif;
}

.flex {
  display: flex;
}

button {
  padding: 10px;
  color: white;
  outline: none;
  border: none;
  font-size: 1em;
  font-weight: bold;
  background-color: #ee4540;
}

button:hover {
  cursor: pointer;
}
</style>
