const header = document.querySelector(".site-header");

const updateHeader = () => {
  header.classList.toggle("is-scrolled", window.scrollY > 24);
};

updateHeader();
window.addEventListener("scroll", updateHeader, { passive: true });

const hotVideo = document.querySelector(".hot-video[data-start]");

if (hotVideo) {
  const startAt = Number(hotVideo.dataset.start);
  const seekToStart = () => {
    if (Number.isFinite(startAt) && hotVideo.duration > startAt) {
      hotVideo.currentTime = startAt;
    }
  };

  if (hotVideo.readyState >= 1) {
    seekToStart();
  } else {
    hotVideo.addEventListener("loadedmetadata", seekToStart, { once: true });
  }

  hotVideo.addEventListener("ended", () => {
    seekToStart();
    hotVideo.play().catch(() => {});
  });
}
