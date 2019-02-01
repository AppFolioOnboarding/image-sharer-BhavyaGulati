import { expect } from 'chai';
import FeedbackStore from "../../stores/FeedbackStore";
import sinon from "sinon";
import * as apiHelper from "../../utils/helper";
import React from "react";
import PostFeedbackService from "../../services/PostFeedbackService";

describe('PostFeedbackService', () => {
  let sandbox;

  beforeEach(() => {
    sandbox = sinon.createSandbox();

  });

  afterEach(() => {
    sandbox.restore();
  });

  it('should successfully post', () => {
    const feedbackStore = new FeedbackStore();
    const postStub = sandbox.stub(apiHelper, 'post').resolves();

    return new PostFeedbackService(feedbackStore).postFeedback().then(() => {
      sinon.assert.calledOnce(postStub);
      expect(feedbackStore.alertMessage).to.equal('Feedback submitted');
    });
  });

  it('should fail to post', () => {
    const feedbackStore = new FeedbackStore();
    const postStub = sandbox.stub(apiHelper, 'post').rejects();

    return new PostFeedbackService(feedbackStore).postFeedback().then(() => {
      sinon.assert.calledOnce(postStub);
      expect(feedbackStore.alertMessage).to.equal('Could not save feedback');
    });
  });
});
