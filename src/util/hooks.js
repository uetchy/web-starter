import React, { useEffect, useRef } from "react";
import styled from "styled-components";

export function useInlineSVG(svg, css = "") {
  const svgRef = useRef();

  useEffect(() => {
    svgRef.current.innerHTML = svg;
  }, []);

  const Container = styled.div`
    ${css}
  `;

  const render = () => <Container ref={svgRef} />;
  return render;
}
