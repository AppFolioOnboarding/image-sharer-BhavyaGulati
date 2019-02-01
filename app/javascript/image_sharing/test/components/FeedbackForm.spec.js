import 'jsdom-global/register';
import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import { expect, equal } from 'chai';
import FeedbackForm from '../../components/FeedbackForm';
import FeedbackStore from "../../stores/FeedbackStore";
import Adapter from 'enzyme-adapter-react-16';
import sinon from 'sinon';
import { FormRow, Alert } from 'react-gears';

describe('<FeedbackForm />', () => {
  configure({adapter: new Adapter()});

  let feedbackStore;
  beforeEach(() => {
    feedbackStore = new FeedbackStore();
  });

  it('should render correct components', () => {
    const wrapper = mount(
      <FeedbackForm stores={{feedbackStore: feedbackStore}}/>
    );

    expect(wrapper.find('FormRow[label="Your name"]').props().value).to.equal('');
    expect(wrapper.find('FormRow[label="Comment"]').props().value).to.equal('');

    const name = "Selenium Gomez";
    const feedback = "Go team!";
    feedbackStore.setName(name);
    feedbackStore.setFeedback(feedback);

    wrapper.update();

    expect(wrapper.find('FormRow[label="Your name"]').props().value).to.equal(name);
    expect(wrapper.find('FormRow[label="Comment"]').props().value).to.equal(feedback);
  });

  it('should render store update on form element change', () => {
    const wrapper = shallow(
      <FeedbackForm stores = {{feedbackStore: feedbackStore}}/>
    ).dive();

    const nameSpy = sinon.spy(feedbackStore, 'setName');
    const feedbackSpy = sinon.spy(feedbackStore, 'setFeedback');

    const name = "Selenium Gomez";
    const feedback = "Go team!";

    wrapper.find('FormRow[label="Your name"]').simulate('change', {target: {value: name}});
    wrapper.find('FormRow[label="Comment"]').simulate('change', {target: {value: feedback}});

    expect(nameSpy.calledWith(name)).to.be.true;
    expect(feedbackSpy.calledWith(feedback)).to.be.true;
  });

  it('should display alertMessage', () => {
    const failure_alert = "Could not save feedback";
    feedbackStore.setAlertMessage(failure_alert);
    const wrapper = mount(
      <FeedbackForm stores={{feedbackStore: feedbackStore}}/>
    );

    expect(wrapper.find('Alert').at(0).text()).to.equal(failure_alert);
  });
});
