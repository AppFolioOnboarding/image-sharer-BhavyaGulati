import 'jsdom-global/register';
import React from 'react';
import { mount, configure } from 'enzyme';
import { expect } from 'chai';
import App from '../../components/App';
import Adapter from 'enzyme-adapter-react-16';

describe('<App />', () => {
  configure({ adapter: new Adapter() });

  it('should render sub-components', () => {
    const wrapper = mount(
      <App stores={[]}/>
    );

    expect(wrapper.find('Header')).to.have.lengthOf(1);
    expect(wrapper.find('Footer')).to.have.lengthOf(1);
  });
});
