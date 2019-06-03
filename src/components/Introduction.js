import React from "react";
import styled from "styled-components";

export default function IntroductionSection() {
  return (
    <Container>
      <Inner>
        <Title>Indecipherable Title</Title>
        <Text>Long passage goes here.</Text>
      </Inner>
    </Container>
  );
}

const Container = styled.div`
  position: relative;
  background: black;
`;

const Inner = styled.div`
  width: 100%;
  position: relative;
  padding: 200px;
  background-color: rgba(0, 0, 0, 0.1);
  background-image: linear-gradient(to left, transparent, #050113 70%);

  text-align: left;
  font-family: serif;
  color: white;
  -webkit-font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
  font-feature-settings: "kern", "palt", "pwid";
  -webkit-font-feature-settings: "kern", "palt", "pwid";
  -moz-font-feature-settings: "kern", "palt", "pwid";
  -moz-font-feature-settings: "kern=1", "palt", "pwid";

  @media screen and (max-width: 600px) {
    padding: 50px;
  }
`;

const Title = styled.h1`
  font-weight: lighter;
`;

const Text = styled.p`
  width: 50%;
  margin-top: 50px;

  font-size: 0.8em;
  line-height: 2.3em;
  font-weight: lighter;

  @media screen and (max-width: 1500px) {
    width: 80%;
  }

  @media screen and (max-width: 900px) {
    width: auto;
  }
`;
