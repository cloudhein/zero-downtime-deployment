const request = require("supertest");
const { app, server } = require("./index");

describe("GET /api/v1/hello", () => {
  test('should return a JSON response with the message "Bonjour"', async () => {
    const response = await request(app).get("/api/v1/hello").expect(200);

    expect(response.body.message).toBe("Bonjour");
  });

  test('should not return a JSON response with the message "hi"', async () => {
    const response = await request(app).get("/api/v1/hello").expect(200);

    expect(response.body.message).not.toBe("hi");
  });
});

afterAll(() => {
  server.close();
});
