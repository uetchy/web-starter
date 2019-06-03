import React from "react";
import styled from "styled-components";

import staffList from "../constants/staff";

export default function StaffSection() {
  return (
    <Container>
      <h1>スタッフ</h1>
      <StaffList>
        {staffList.map((staff, i) => (
          <Section key={i}>
            <SectionTitle>{staff.kind}</SectionTitle>

            {staff.involves.map((person, j) => (
              <Staff key={j}>
                <Name>
                  <Link href={person.url}>{person.name}</Link>
                </Name>
                <Belong>{person.belong}</Belong>
              </Staff>
            ))}
          </Section>
        ))}
      </StaffList>
    </Container>
  );
}

const Container = styled.div`
  padding: 200px;
  background: white;
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

const StaffList = styled.div``;

const Section = styled.div`
  margin-top: 100px;

  @media screen and (max-width: 900px) {
    margin-top: 50px;
  }
`;

const SectionTitle = styled.h2``;

const Staff = styled.div`
  margin-top: 25px;
`;

const Name = styled.h2`
  font-size: 1.5em;
`;

const Link = styled.a.attrs({ target: "_blank", rel: "noopener noreferrer" })`
  text-decoration: none;
`;

const Belong = styled.div`
  margin-top: 5px;
  font-size: 0.9em;
  font-weight: 100;
`;
