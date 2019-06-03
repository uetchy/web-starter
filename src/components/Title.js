import React from "react";
import styled, { css } from "styled-components";
import { useInlineSVG } from "../util/hooks";
import LogoSVG from "../assets/logo.svg";

export default function TitleSection() {
  const Logo = useInlineSVG(LogoSVG, logoStyle);

  return (
    <Container>
      <Logo />
    </Container>
  );
}

const Container = styled.div`
  width: 100%;
  height: 100%;
  background-color: #1967bd;

  @media screen and (max-width: 600px) {
    height: 100vh;
  }
`;

const logoStyle = css`
  padding-top: 100px;
  text-align: center;
`;
