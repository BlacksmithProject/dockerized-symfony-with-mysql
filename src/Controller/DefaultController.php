<?php
declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

final class DefaultController
{
    #[Route('/')]
    public function __invoke(): JsonResponse
    {
        $a = 1 + 1;
        $b = 2 + 2;

        return new JsonResponse(['hello world !', $a, $b]);
    }
}
