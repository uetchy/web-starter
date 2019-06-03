import React, { useEffect } from "react";
import ReactGA from "react-ga";

import Title from "./components/Title";
import Introduction from "./components/Introduction";
import Staff from "./components/Staff";

import config from "./constants/config";

ReactGA.initialize(config.googleAnalyticsID);

export default function App() {
  useEffect(() => {
    ReactGA.pageview(window.location.pathname + window.location.search);
  }, []);

  return (
    <>
      <Title />
      <Introduction />
      <Staff />
    </>
  );
}
