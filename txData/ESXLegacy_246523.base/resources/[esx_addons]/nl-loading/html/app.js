const myAudio = document.getElementById("statusAudio");
const subtitleStrong = document.querySelector("#subtitle strong");

if (myAudio) {
  myAudio.volume = 0.1;
  window.addEventListener("load", () => {
    setTimeout(() => {
      myAudio.muted = false;
      myAudio.play().catch(e => console.warn("Autoplay blocked:", e));
    }, 500);
  });
}


window.addEventListener("keydown", (event) => {
  if (event.code === "Space") {
    event.preventDefault();
    if (myAudio.paused) {
      myAudio.play().catch(e => console.error("Playback error:", e));
      if (subtitleStrong) subtitleStrong.style.color = "#ffffff";
    } else {
      myAudio.pause();
      if (subtitleStrong) subtitleStrong.style.color = "#e74c3c";
    }
  }
});


let count = 0;
let thisCount = 0;
const progressBar = document.getElementById("progressBarFill");
const progressText = document.getElementById("progressBarText");

const handlers = {
  startInitFunctionOrder(data) {
    count = data.count;
  },
  initFunctionInvoking(data) {
    if (progressBar && progressText) {
      const percent = (data.idx / count) * 100;
      progressBar.style.width = `${percent}%`;
      progressText.textContent = `CHARGEMENT ${Math.floor(percent)}%`;
    }
  },
  startDataFileEntries(data) {
    count = data.count;
  },
  performMapLoadFunction(data) {
    if (progressBar && progressText) {
      ++thisCount;
      const percent = (thisCount / count) * 100;
      progressBar.style.width = `${percent}%`;
      progressText.textContent = `CHARGEMENT ${Math.floor(percent)}%`;
    }
  },
};

window.addEventListener("message", (e) => {
  (handlers[e.data.eventName] || function () {})(e.data);
});
