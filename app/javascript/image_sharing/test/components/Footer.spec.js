import 'jsdom-global/register';
import React from 'react';
import { mount, configure } from 'enzyme';
import { expect } from 'chai';
import Footer from '../../components/Footer';
import Adapter from 'enzyme-adapter-react-16';

describe('<Footer />', () => {
  configure({ adapter: new Adapter() });

  it('should render correct components', () => {
    const wrapper = mount(
      <Footer />
    );

    expect(wrapper.find('#footer-text').text()).to.equal('Copyright: AppFolio Inc. Onboarding');
  });
});
