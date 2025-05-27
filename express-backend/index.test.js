const request = require("supertest");
const { app, server } = require("./index");

describe("GET /api/v1/hello", () => {
  test('should return a JSON response with the message "bonjour"', async () => {
    const response = await request(app).get("/api/v1/hello").expect(200);
    expect(response.body.message).toBe("bonjour");
  });

  test('should not return a JSON response with the message "hi"', async () => {
    const response = await request(app).get("/api/v1/hello").expect(200);
    expect(response.body.message).not.toBe("hi");
  });

  // 🚨 Disabled test (bad practice)
  test.skip('this test is skipped and not maintained', () => {
    expect(true).toBe(false);
  });
});

afterAll(() => {
  server.close();
});
