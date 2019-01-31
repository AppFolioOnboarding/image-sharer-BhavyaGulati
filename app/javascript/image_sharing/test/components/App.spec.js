import 'jsdom-global/register';
import React from 'react';
import { mount, configure } from 'enzyme';
import { expect } from 'chai';
import App from '../../components/App';
import Adapter from 'enzyme-adapter-react-16';
import FeedbackStore from "../../stores/FeedbackStore";
import {Provider} from "mobx-react";

describe('<App />', () => {
  configure({ adapter: new Adapter() });

  it('should render sub-components', () => {
    const wrapper = mount(
      <Provider stores={{feedbackStore: new FeedbackStore()}}>
        <App/>
      </Provider>
    );

    expect(wrapper.find('Header')).to.have.lengthOf(1);
    expect(wrapper.find('Footer')).to.have.lengthOf(1);
  });
});
