import { post } from "../utils/helper";

export class PostFeedbackService {
  constructor(feedbackStore) {
    this.feedbackStore = feedbackStore;
  }

  postFeedback = () => {
    return post('/api/feedbacks', {feedback: {
        name: this.feedbackStore.name,
        feedback: this.feedbackStore.feedback
      }}).then(
      () => {
        this.feedbackStore.setName('');
        this.feedbackStore.setFeedback('');
        this.feedbackStore.setAlertMessage('Feedback submitted');
      },
      (error) => {
        this.feedbackStore.setAlertMessage('Could not save feedback');
      }
    );
  }
}

export default PostFeedbackService;
