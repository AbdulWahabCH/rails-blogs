import { createConsumer } from "@rails/actioncable";

let cable;
if (window.App.user.signedIn) {
    cable = createConsumer(`/cable?token=${window.App.user._id}`);
}
export default cable;
