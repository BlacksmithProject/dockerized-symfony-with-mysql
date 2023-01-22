<?php
declare(strict_types=1);

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class DefaultControllerTest extends WebTestCase
{
    /** @test */
    public function hello_world(): void
    {
        // ARRANGE
        $client = self::createClient();

        // ACT
        $client->request('GET', '/');
        $response = $client->getResponse();

        // ASSERT
        self::assertSame(200, $response->getStatusCode());
        self::assertTrue(is_string($response->getContent()));
        self::assertSame(['hello world !'], json_decode($response->getContent(), true));
    }
}
