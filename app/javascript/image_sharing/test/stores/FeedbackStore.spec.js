import { expect } from 'chai';
import FeedbackStore from '../../stores/FeedbackStore';

describe('FeedbackStore', () => {
  let feedbackStore;
  beforeEach(() => {
    feedbackStore = new FeedbackStore();
  });

  it('should initialize correctly', () => {
    expect(feedbackStore.name).to.equal('');
    expect(feedbackStore.feedback).to.equal('');
    expect(feedbackStore.alertMessage).to.equal('');
  });

  it('setName', () => {
    feedbackStore.setName('Selenium Gomez');
    expect(feedbackStore.name).to.equal('Selenium Gomez');
  });

  it('setFeedback', () => {
    feedbackStore.setFeedback('Go team!');
    expect(feedbackStore.feedback).to.equal('Go team!');
  });

  it('setAlertMessage', () => {
    feedbackStore.setAlertMessage('Feedback submitted');
    expect(feedbackStore.AlertMessage).to.equal('Feedback submitted');
  });
});
