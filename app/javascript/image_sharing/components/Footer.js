import React, { Component } from 'react';

const divStyle = {
  fontSize: 10
};

class Footer extends Component {
  /* Implement your Footer component here */
  render() {
    return (
      <div style={divStyle}>
        <footer className='text-center' id='footer-text'>
          Copyright: AppFolio Inc. Onboarding
        </footer>
      </div>
    )
  }
}

export default Footer;
